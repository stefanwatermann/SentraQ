using System.Text.Json;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler.Handler;

/// <summary>
/// Actor Messages verarbeiten.
/// </summary>
/// <param name="dbContext"></param>
/// <param name="settings"></param>
/// <param name="cacheService"></param>
/// <param name="logger"></param>
public class ActorMessageHandler(
    DatabaseContext dbContext,
    SettingService settings,
    CacheService cacheService,
    LogService logService,
    ILogger<ActorMessageHandler> logger) : IMessageHandler
{
    public void HandleMessage(MqttPayload payload)
    {
        var component = cacheService.GetComponent(payload);
        if (component == null) 
            return;
        
        var value = Convert.ToInt32(payload.Value.ToString());
        
        logger.LogDebug("ActorMessageHandler: {hid} Message received with value {v}", payload.Hid, value);
        
        if (cacheService.CounterExists(payload))
            HandleCounter(payload);
    }

    // Betriebsstundenzähler: Zählt die Zeit zwischen Events mit dem Wert 1 und addiert diese auf.
    // In der Tabelle Counter muss dazu für den Actor eine Zeile mit der HardwareId vorhanden sein.
    private void HandleCounter(MqttPayload payload)
    {
        var counter = dbContext
            .Counters
            .First(c => c.HardwareId == payload.Hid);
        
        // ensure that latest data has been loaded
        dbContext.Entry(counter).Reload();
        
        logger.LogDebug("ActorMessageHandler: reloaded Counter={counter}", JsonSerializer.Serialize(counter));
        
        counter.LastTs ??= DateTime.Now;
        
        var payloadValue = Convert.ToInt32(payload.Value.ToString() ?? "0");

        var timeSpan = DateTime.Now.Subtract(counter.LastTs.Value);
        
        // prevent wrong counter value if messages from station were lost due to outage or failure
        if (counter.LastValue is 1 && counter.LastTs < DateTime.Now.AddMinutes(-5))
        {
            counter.LastValue = 0;
            logService.AddInfo(LogService.Event.ActorCounterRestart, $"Counter LastValue set to 0 because last timestamp was too old (>5 minutes). Station outage?");
        }

        if (counter.LastValue is 1)
        {
            var sec = Convert.ToInt64(timeSpan.TotalSeconds);
            logger.LogDebug("ActorMessageHandler: counter={counter}, sec={sec}, lastValue={lastValue}, payload={payload}", counter, sec, counter.LastValue, payloadValue);
            counter.Count += sec;
        }
        
        counter.LastValue = payloadValue;
        counter.LastTs = DateTime.Now;
        
        logger.LogDebug("ActorMessageHandler: dbContextId={ctxid}, hid={hid}", dbContext.ContextId, payload.Hid);
        dbContext.SaveChanges(true);
    }
}