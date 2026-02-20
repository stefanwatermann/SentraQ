using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Mqtt;
using SentraqWatchdog.Models;

namespace SentraqWatchdog.Services;

/// <summary>
/// SentraQ Watchdog service. Sends fault (type=FL) messages for Stations with configured WatchdogId.
/// Sends 0 if messages are being received frequently and 1 if no new messages have arrived
/// within the configured time periode (WatchdogAlertAfterSeconds).
/// </summary>
public class WatchdogService(
    MqttSenderService mqttSenderService,
    SettingService settings,
    DatabaseContext dbContext)
{
    private readonly int _watchdogAlertAfterSeconds = settings.WatchdogAlertAfterSeconds;

    public void Watch()
    {
        // get Stations with Watchdog faults to be alerted
        var stationsToBeAlerted = GetStationsToAlert();
        
        if (stationsToBeAlerted.Any())
        {
            foreach (var station in stationsToBeAlerted)
            {
                SendWatchdogMessage(station, "1");
            }
        }

        // get Stations without Watchdog fault
        var stationsToBeUnAlerted = GetStationsToClearAlert(stationsToBeAlerted);

        // send Value 0 for all Stations without Watchdog fault
        if (stationsToBeUnAlerted.Any())
        {
            foreach (var station in stationsToBeUnAlerted)
            {
                SendWatchdogMessage(station, "0");
            }
        }
    }

    /// <summary>
    /// Send Watchdog message to MQTT broker for station.
    /// </summary>
    /// <param name="station"></param>
    /// <param name="payload"></param>
    private void SendWatchdogMessage(WatchdogStation station, string payload)
    {
        // create an alert station
        var mqttPayload = new MqttPayload()
        {
            Topic = settings.ControllerMqttClientTopic,
            Hid = station.WatchdogHardwareId,
            Value = payload,
            TS = DateTime.Now
        };

        mqttSenderService.Send(mqttPayload);
    }

    /// <summary>
    /// Get list of Stations with Watchdog set and at least on message received.
    /// </summary>
    /// <returns></returns>
    private List<WatchdogStation> GetWatchdogStations()
    {
        var data = dbContext
            .ComponentsView
            .Include(c => c.Station)
            .Where(
                c =>
                    !string.IsNullOrWhiteSpace(c.Station.WatchdogHardwareId) &&
                    c.HardwareId != c.Station.WatchdogHardwareId &&
                    c.LastReceivedTs.HasValue
            )
            .GroupBy(s => new
            {
                s.StationUid,
                s.Station.WatchdogHardwareId
            })
            .Select(s => new
            {
                s.Key.StationUid,
                s.Key.WatchdogHardwareId,
                LastReceivedTs = s.Max(g => g.LastReceivedTs)
            }).Select(c => new WatchdogStation()
            {
                StationUid = c.StationUid,
                WatchdogHardwareId = c.WatchdogHardwareId,
                LastReceivedTs = c.LastReceivedTs.Value
            }).ToList();

        return data;
    }

    /// <summary>
    /// Stations with Watchdog set and time of last message older than _watchdogAlertAfterSeconds.
    /// </summary>
    /// <returns></returns>
    private List<WatchdogStation> GetStationsToAlert()
    {
        return GetWatchdogStations()
            .Where(c => 
                DateTime.Now.Subtract(c.LastReceivedTs).TotalSeconds > _watchdogAlertAfterSeconds)
            .ToList();
    }

    /// <summary>
    /// Stations with Watchdog set and no active watchdog alert.
    /// </summary>
    /// <param name="stationsToAlert"></param>
    /// <returns></returns>
    private List<WatchdogStation> GetStationsToClearAlert(List<WatchdogStation> stationsToAlert)
    {
        var watchdogStations = GetWatchdogStations();
        return watchdogStations.Where(station => 
            stationsToAlert.FirstOrDefault(c => c.StationUid == station.StationUid) == null)
            .ToList();
    }
}