using System.Text.Json;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Data;
using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler.Handler;

public class AlertMessageHandler(
    DatabaseContext dbContext,
    SettingService settings,
    CacheService cacheService,
    ILogger<AlertMessageHandler> logger) : IMessageHandler
{
    public void HandleMessage(MqttPayload payload)
    {
        logger.LogDebug("Fault message received with payload {p}", payload);

        var component = cacheService.GetComponent(payload);
        if (component == null)
            return;

        var currentFaultValue = Convert.ToInt32(payload.Value.ToString());
        var currentHid = payload.Hid;
        var currentStationUid = component.Station.Uid;

        if (!WaitFaultsReceived(currentHid, currentFaultValue))
        {
            logger.LogInformation(
                "{hid} AlertWaitFaultCount not reached, still waiting before creating alert", currentHid);
            return;
        }

        var activeAlert = dbContext
            .Alerts
            .FirstOrDefault(a => a.StationUid == currentStationUid && a.IsActive == "Y");

        if (activeAlert != null)
        {
            // ensure that latest data has been loaded
            dbContext.Entry(activeAlert).Reload();
            logger.LogDebug("reloaded Alert={alert}", JsonSerializer.Serialize(activeAlert));
        }

        if (currentFaultValue != 0)
        {
            if (activeAlert == null)
            {
                logger.LogInformation("No active Alert found for Station {uid}, creating new Alert.", currentStationUid);
                activeAlert = new Alert()
                {
                    StationUid = currentStationUid,
                    FirstEventTs = DateTime.Now
                };
                dbContext.Alerts.Add(activeAlert);
            }

            activeAlert.IsActive = "Y";
            activeAlert.LastEventTs = DateTime.Now;
        }
        
        // Gibt es noch weitere Faults zu der Station?
        var componentsCachedValue = dbContext
            .Components
            .Where(cm => cm.Station.Uid == currentStationUid && cm.Type == "FL")
            .ToList()
            .Select(cm => cacheService.GetLastPayloadValueCacheByHardwareId(cm.HardwareId));
        
        var stationHasFaults = componentsCachedValue
            .Any(f => f is { LastPayload: "1" });
        
        // wenn nicht, kann der Alarm beendet werden.
        if (!stationHasFaults)
        {
            if (activeAlert != null)
            {
                activeAlert.IsActive = "N";
                activeAlert.LastEventTs = DateTime.Now;
                logger.LogInformation("Alert cleared for Station {uid}, no more faults found.", currentStationUid);
            }
        }

        logger.LogDebug("dbContextId={ctxId}, hid={hid}", dbContext.ContextId, currentHid);
        dbContext.SaveChanges();
    }

    private bool WaitFaultsReceived(string hid, int faultValue)
    {
        // reset counter if faultValue is 0
        if (faultValue == 0)
        {
            cacheService.SetFaultCounter(hid, 0);
            return true;
        }

        // increase fault counter
        var current = cacheService.GetFaultCounter(hid);
        cacheService.SetFaultCounter(hid, ++current);

        logger.LogDebug("AlertMessageHandler: AlertWaitFaultCount={current}", current);

        return current >= settings.AlertWaitFaultCount;
    }
}