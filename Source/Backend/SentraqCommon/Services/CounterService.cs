// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

/// <summary>
/// Manage access to Counters stored in table Counter.
/// </summary>
/// <param name="logService"></param>
/// <param name="userService"></param>
/// <param name="dbContext"></param>
public class CounterService(
    LogService logService,
    UserService userService,
    DatabaseContext dbContext)
{
    public void WriteCounter(Counter counter, string changedBy)
    {
        userService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var existing = dbContext
            .Counters
            .SingleOrDefault(c => c.HardwareId == counter.HardwareId);

        if (existing != null)
        {
            // update existing station
            existing.ShortName = counter.ShortName;
            existing.DisplayName = counter.DisplayName;
            existing.DisplayOrder = counter.DisplayOrder;
            existing.AdjustmentFunction = counter.AdjustmentFunction;
            existing.DisplayUnit = counter.DisplayUnit;
            existing.Removed = false;
            existing.Type = counter.Type;
            existing.Visible = counter.Visible;
        }
        else
        {
            // add new station
            dbContext.Add(counter);
        }

        logService.AddInfoNoSave(LogService.Event.CounterChanged, $"Counter {counter.ShortName} ({counter.HardwareId}) changed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void RemoveCounter(string hardwareId, string changedBy)
    {
        userService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var counter = dbContext
                          .Counters
                          .SingleOrDefault(c => c.HardwareId == hardwareId) ??
                      throw new KeyNotFoundException($"Counter {hardwareId} not found.");

        counter.Removed = true;
        
        logService.AddInfoNoSave(LogService.Event.CounterRemoved, $"Component {counter.ShortName} ({counter.HardwareId}) removed by {changedBy}.");
        dbContext.SaveChanges();
    }
}