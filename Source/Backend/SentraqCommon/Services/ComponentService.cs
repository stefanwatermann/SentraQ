using System.Diagnostics.CodeAnalysis;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqCommon.MqttSender;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class ComponentService(
    ILogger<ComponentService> logger,
    LogService logService,
    SiemensLogo8MqttSender siemensLogo8MqttSender,
    AuthorizationService authorizationService,
    DatabaseContext dbContext)
{
    public Component? GetComponentByUid(string uid)
    {
        return dbContext
            .Components
            .Include(c => c.Station)
            .FirstOrDefault(c => c.HardwareId == uid);
    }
    
    public void SetValue(string hardwareId, string value, string changedBy)
    {
        var component = GetComponentByUid(hardwareId);
        
        if (component == null)
            throw new Exception($"Component with uid '{hardwareId}' not found");
        
        siemensLogo8MqttSender.Send(component, value);
        
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
}