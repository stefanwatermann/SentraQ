using System.Diagnostics;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using Data = SentraqModels.Data;

namespace SentraqCommon.Services;

public class StationService(
    ILogger<StationService> logger,
    LogService logService,
    AuthorizationService authorizationService,
    DatabaseContext dbContext)
{
    public IEnumerable<Data.StationView> GetStationsView()
    {
        return dbContext
            .StationsView
            .OrderBy(s => s.DisplayOrder);
    }
    
    public Data.StationView? GetStationView(string stationUid)
    {
        return dbContext
            .StationsView
            .FirstOrDefault(s => s.Uid == stationUid);
    }
    
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
    
    public void WriteStation(Data.Station station, string changedBy)
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

        logService.AddInfo(LogService.Event.StationChanged, $"{station.ShortName} ({station.Uid}) changed by {changedBy}.");
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
        
        logService.AddInfo(LogService.Event.StationRemoved, $"{station.ShortName} ({station.Uid}) removed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void SetMaintenanceMode(string uid, DateTime? startTs, string changedBy)
    {
        var station = dbContext
                          .Stations
                          .SingleOrDefault(s => s.Uid == uid) ??
                      throw new KeyNotFoundException($"Station {uid} not found.");

        station.MaintenanceActiveSinceTs = startTs;
        
        if (startTs != null)
            logService.AddInfo(LogService.Event.StationMaintenanceStarted, $"{station.ShortName} ({station.Uid}) maintenance mode started by {changedBy}.");
        else
            logService.AddInfo(LogService.Event.StationMaintenanceStopped, $"{station.ShortName} ({station.Uid}) maintenance mode cleared by {changedBy}.");
        
        dbContext.SaveChanges();
    }

    public void EvaluateStationsMaintenanceModeActiveStatus()
    {
        foreach (var station in GetStationsView().ToList())
        {
            dbContext.Entry(station).Reload();
            
            if (station.MaintenanceActiveSinceTs.HasValue &&
                station.MaintenanceActiveSinceTs.Value.AddHours(12) <= DateTime.Now &&
                (!station.MaintenanceActiveAlertSentTs.HasValue || 
                 station.MaintenanceActiveAlertSentTs.Value.AddHours(12) <= DateTime.Now))
            {
                // TODO Mail senden
                logger.LogInformation($"Station {station.ShortName} ({station.Uid}) maintenance mode active for more than 12h.");
            }
        }
    }
}