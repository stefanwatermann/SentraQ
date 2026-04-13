using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class ComponentService(
    ILogger<CacheService> logger,
    LogService logService,
    AuthorizationService authorizationService,
    DatabaseContext dbContext)
{
    public Component? GetComponentByUid(string uid)
    {
        return dbContext
            .Components
            .FirstOrDefault(c => c.HardwareId == uid);
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

        logService.AddInfo(LogService.Event.ComponentChanged, $"Component {component.ShortName} ({component.HardwareId}) changed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void Removecomponent(string hardwareId, string changedBy)
    {
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var component = dbContext
                          .Components
                          .SingleOrDefault(c => c.HardwareId == hardwareId) ??
                      throw new KeyNotFoundException($"Component {hardwareId} not found.");

        component.Removed = true;
        
        logService.AddInfo(LogService.Event.ComponentRemoved, $"Component {component.ShortName} ({component.HardwareId}) removed by {changedBy}.");
        dbContext.SaveChanges();
    }
}