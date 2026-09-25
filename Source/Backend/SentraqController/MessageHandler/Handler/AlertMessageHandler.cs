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
        var faultValue = Convert.ToInt32(payload.Value.ToString());

        logger.LogDebug("{hid} Fault message received with value {v}", payload.Hid, faultValue);

        var component = cacheService.GetComponent(payload);
        if (component == null)
            return;
        
        if (!WaitFaultsReceived(payload.Hid, faultValue))
        {
            logger.LogDebug("{hid} MaxWaitFaultsReceived not reached, still waiting before sending alert", payload.Hid);
            return;
        }

        var componentsCachedValue = dbContext
            .Components
            .Where(cm => cm.Station.Uid == component.Station.Uid && cm.Type == "FL")
            .ToList()
            .Select(cm => cacheService.GetPayloadValueCacheByHardwareId(cm.HardwareId));
        
        var hasFaults = faultValue != 0 || componentsCachedValue.Any(f => f != null && f.LastPayload == "1");

        var activeAlert = dbContext
            .Alerts
            .FirstOrDefault(a => a.StationUid == component.Station.Uid && a.IsActive == "Y");

        if (activeAlert != null)
        {
            // ensure that latest data has been loaded
            dbContext.Entry(activeAlert).Reload();
            logger.LogDebug("reloaded Alert={alert}", JsonSerializer.Serialize(activeAlert));
        }

        if (hasFaults)
        {
            if (activeAlert == null)
            {
                logger.LogInformation("No active Alert found for {hid}, creating new Alert.", payload.Hid);
                activeAlert = new Alert()
                {
                    StationUid = component.Station.Uid,
                    FirstEventTs = DateTime.Now
                };
                dbContext.Alerts.Add(activeAlert);
            }

            activeAlert.IsActive = "Y";
            activeAlert.LastEventTs = DateTime.Now;
        }
        else
        {
            if (activeAlert != null)
            {
                activeAlert.IsActive = "N";
                activeAlert.LastEventTs = DateTime.Now;
            }
        }
        
        logger.LogDebug("dbContextId={ctxId}, hid={hid}", dbContext.ContextId, component.HardwareId);
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