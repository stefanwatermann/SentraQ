using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class StationService(
    ILogger<StationService> logger,
    LogService logService,
    AuthorizationService authorizationService,
    DatabaseContext dbContext)
{
    public void ClearAlert(string stationUid, string user)
    {
        var alert = dbContext
            .Alerts
            .FirstOrDefault(a => a.StationUid == stationUid && a.IsActive == "Y");

        if (alert is null)
            return;

        alert.ConfirmedAt = DateTime.Now;
        alert.ConfirmedBy = user;
        
        logService.AddInfo(LogService.Event.AlertAction,$"Alert for station {stationUid} cleared by {user}");
        
        dbContext.SaveChanges(true);
    }
    
    public void WriteStation(Station station, string changedBy)
    {
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var existing = dbContext
            .Stations
            .SingleOrDefault(s => s.Uid == station.Uid);

        if (existing != null)
        {
            // update existing station
            existing.ShortName = station.ShortName;
            existing.DisplayName = station.DisplayName;
            existing.Latitude = station.Latitude;
            existing.Longitude = station.Longitude;
            existing.WatchdogHardwareId = station.WatchdogHardwareId;
            existing.DisplayColor = station.DisplayColor;
            existing.DisplayOrder = station.DisplayOrder;
            existing.AlertReceiverEmailAddresses = station.AlertReceiverEmailAddresses;
            existing.Removed = false;
        }
        else
        {
            // add new station
            dbContext.Add(station);
        }

        logService.AddInfo(LogService.Event.StationChanged, $"Station {station.ShortName} ({station.Uid}) changed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void RemoveStation(string uid, string changedBy)
    {
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var station = dbContext
                       .Stations
                       .SingleOrDefault(s => s.Uid == uid) ??
                   throw new KeyNotFoundException($"Station {uid} not found.");

        station.Removed = true;
        
        logService.AddInfo(LogService.Event.StationRemoved, $"Station {station.ShortName} ({station.Uid}) removed by {changedBy}.");
        dbContext.SaveChanges();
    }
}