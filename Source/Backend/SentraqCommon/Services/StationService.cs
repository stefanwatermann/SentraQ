// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using Data = SentraqModels.Data;

namespace SentraqCommon.Services;

/// <summary>
/// Manage Station data stored in table Station.
/// </summary>
/// <param name="logger"></param>
/// <param name="logService"></param>
/// <param name="mailService"></param>
/// <param name="settingService"></param>
/// <param name="userService"></param>
/// <param name="dbContext"></param>
public class StationService(
    ILogger<StationService> logger,
    LogService logService,
    MailService mailService,
    SettingService settingService,
    UserService userService,
    DatabaseContext dbContext)
{
    public IEnumerable<Data.Station> GetStations()
    {
        return dbContext
            .Stations
            .OrderBy(s => s.DisplayOrder);
    }
    
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
        
        logService.AddInfoNoSave(LogService.Event.AlertAction,$"Alert for station {stationUid} cleared by {user}");
        
        dbContext.SaveChanges(true);
    }
    
    public void WriteStation(Data.Station station, string changedBy)
    {
        userService.ThrowWhenChangedByUserNotAdmin(changedBy);

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
            existing.Removed = station.Removed;
            existing.Visible = station.Visible;
        }
        else
        {
            // add new station
            dbContext.Add(station);
        }

        logService.AddInfoNoSave(LogService.Event.StationChanged, $"{station.ShortName} ({station.Uid}) changed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void RemoveStation(string uid, string changedBy)
    {
        userService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var station = dbContext
                       .Stations
                       .SingleOrDefault(s => s.Uid == uid) ??
                   throw new KeyNotFoundException($"Station {uid} not found.");

        station.Removed = true;
        
        logService.AddInfoNoSave(LogService.Event.StationRemoved, $"{station.ShortName} ({station.Uid}) removed by {changedBy}.");
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
            logService.AddInfoNoSave(LogService.Event.StationMaintenanceStarted, $"{station.ShortName} ({station.Uid}) maintenance mode started by {changedBy}.");
        else
            logService.AddInfoNoSave(LogService.Event.StationMaintenanceStopped, $"{station.ShortName} ({station.Uid}) maintenance mode cleared by {changedBy}.");
        
        dbContext.SaveChanges();
    }

    public void EvaluateAndAlertStationMaintenanceModeActive()
    {
        foreach (var station in GetStations().ToList())
        {
            dbContext.Entry(station).Reload();
            
            if (station.MaintenanceActiveSinceTs.HasValue &&
                station.MaintenanceActiveSinceTs.Value.AddHours(settingService.MaintenanceActiveAlertAfterHours) <= DateTime.Now &&
                (!station.MaintenanceActiveAlertSentTs.HasValue || 
                 station.MaintenanceActiveAlertSentTs.Value.AddHours(settingService.MaintenanceActiveAlertAfterHours) <= DateTime.Now))
            {
                logger.LogInformation($"Station {station.ShortName} ({station.Uid}) maintenance mode active for more than {settingService.MaintenanceActiveAlertAfterHours:F0} hours.");
                mailService.SendMaintenanceActiveMessage(station);
                station.MaintenanceActiveAlertSentTs = DateTime.Now;
                dbContext.SaveChanges();
            }
        }
    }
}