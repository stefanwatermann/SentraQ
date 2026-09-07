using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;
using SentraqCommon.MqttMessageBuilder;
using SentraqCommon.MqttSender;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class ComponentService(
    LogService logService,
    MqttMessageSender mqttMessageSender,
    MqttMessageBuilderFactory mqttMessageBuilderFactory,
    AuthorizationService authorizationService,
    DatabaseContext dbContext)
{
    public void SendValue(string hardwareId, string? value, string changedBy)
    {
        var component = GetComponentByUid(hardwareId);
        
        if (component == null)
            throw new Exception($"Component with uid '{hardwareId}' not found");

        // create message for the target component
        var messageBuilder = mqttMessageBuilderFactory.CreateMessageBuilder(component.Station.StationControllerTypeName);
        var payload = messageBuilder.CreatePayloadFor(component, value);
        
        // send data to component
        mqttMessageSender.SendAsync(payload, component.Station.Uid);
        
        logService.Add(
            LogService.Event.ComponentValueSet, 
            LogService.Severity.Info, 
            $"Component '{hardwareId}' has been set to {value} by user {changedBy}");
    }
    
    public void WriteComponent(Component component, string changedBy)
    {
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var existing = dbContext
            .Components
            .SingleOrDefault(c => c.HardwareId == component.HardwareId);

        if (existing != null)
        {
            // update existing station
            existing.ShortName = component.ShortName;
            existing.DisplayName = component.DisplayName;
            existing.DisplayOrder = component.DisplayOrder;
            existing.AdjustmentFunction = component.AdjustmentFunction;
            existing.DisplayUnit = component.DisplayUnit;
            existing.MaxValue = component.MaxValue;
            existing.MinValue = component.MinValue;
            existing.Removed = false;
        }
        else
        {
            // add new station
            dbContext.Add(component);
        }

        logService.AddInfoNoSave(LogService.Event.ComponentChanged, $"Component {component.ShortName} ({component.HardwareId}) changed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void RemoveComponent(string hardwareId, string changedBy)
    {
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var component = dbContext
                          .Components
                          .SingleOrDefault(c => c.HardwareId == hardwareId) ??
                      throw new KeyNotFoundException($"Component {hardwareId} not found.");

        component.Removed = true;
        
        logService.AddInfoNoSave(LogService.Event.ComponentRemoved, $"Component {component.ShortName} ({component.HardwareId}) removed by {changedBy}.");
        dbContext.SaveChanges();
    }
    
    private Component? GetComponentByUid(string uid)
    {
        return dbContext
            .Components
            .Include(c => c.Station)
            .FirstOrDefault(c => c.HardwareId == uid);
    }
}