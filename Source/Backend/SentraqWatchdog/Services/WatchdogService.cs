using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Mqtt;

namespace SentraqWatchdog.Services;

internal class WatchdogStation
{
    public string StationUid { get; set; }
    public string WatchdogHardwareId { get; set; }
    public DateTime LastReceivedTs { get; set; }
}

public class WatchdogService(
    MqttSenderService mqttSenderService,
    SettingService settings,
    DatabaseContext dbContext)
{
    private readonly int _watchdogAlertAfterSeconds = settings.WatchdogAlertAfterSeconds;

    public void Watch()
    {
        // alle Stations mit gesetztem Watchdog und ausbleibenden Messages
        var stationsToBeAlerted = GetStationsToBeAlerted();
        
        if (stationsToBeAlerted.Any())
        {
            foreach (var station in stationsToBeAlerted)
            {
                SendWatchdogMessage(station, "1");
            }
        }

        // Stationen ohne Störung ermitteln
        var stationsToBeUnAlerted = GetStationsToBeUnAlerted(stationsToBeAlerted);

        // Value 0 senden, für alle ohne Störung
        if (stationsToBeUnAlerted.Any())
        {
            foreach (var station in stationsToBeUnAlerted)
            {
                SendWatchdogMessage(station, "0");
            }
        }
    }

    private void SendWatchdogMessage(WatchdogStation station, string payload)
    {
        // get latest value of watchdog
        var lastWatchdogValue = dbContext
            .ComponentsView
            .Where(c => c.HardwareId == station.WatchdogHardwareId)
            .OrderByDescending(c => c.LastReceivedTs)
            .FirstOrDefault();

        // do not send message if last payload is already set to payload-value
        if (lastWatchdogValue == null &&
            string.IsNullOrWhiteSpace(lastWatchdogValue.LastPayload) ||
            lastWatchdogValue.LastPayload == payload) return;

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

    private List<WatchdogStation> GetStationsToBeAlerted()
    {
        return GetWatchdogStations()
            .Where(c => 
                DateTime.Now.Subtract(c.LastReceivedTs).TotalSeconds > _watchdogAlertAfterSeconds)
            .ToList();
    }

    private List<WatchdogStation> GetStationsToBeUnAlerted(List<WatchdogStation> stationsToBeAlerted)
    {
        var watchdogStations = GetWatchdogStations();
        return watchdogStations.Where(station => 
            stationsToBeAlerted.FirstOrDefault(c => c.StationUid == station.StationUid) == null)
            .ToList();
    }
}