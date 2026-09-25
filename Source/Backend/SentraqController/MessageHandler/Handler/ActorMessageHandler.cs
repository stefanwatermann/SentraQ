using System.Text.Json;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Data;
using SentraqModels.Enums;
using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler.Handler;

/// <summary>
/// Actor Messages verarbeiten.
/// </summary>
/// <param name="dbContext"></param>
/// <param name="cacheService"></param>
/// <param name="logger"></param>
public class ActorMessageHandler(
    DatabaseContext dbContext,
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
        
        logger.LogDebug("{hid} Message received with value {v}", payload.Hid, value);
        
        // does actor have a counter configured?
        if (cacheService.CounterExists(payload))
            HandleCounter(payload);
    }
    
    // In der Tabelle Counter muss für den Actor eine Zeile mit der HardwareId vorhanden sein.
    private void HandleCounter(MqttPayload payload)
    {
        var counter = dbContext
            .Counters
            .First(c => c.HardwareId == payload.Hid);
        
        // ensure that latest counter status has been loaded
        dbContext.Entry(counter).Reload();
        
        logger.LogDebug("reloaded Counter={counter}", JsonSerializer.Serialize(counter));

        switch (counter.Type)
        {
            case CounterType.timediff:
                HandleTimeDiffCounter(counter, payload);
                break;

            case CounterType.valueadd:
                HandlePayloadValueAddCounter(counter, payload);
                break;
            
            default:
                HandleTimeDiffCounter(counter, payload);
                break;
        }
        
        logger.LogDebug("ActorMessageHandler: dbContextId={ctxid}, hid={hid}", dbContext.ContextId, payload.Hid);
        dbContext.SaveChanges(true);
    }

    // Betriebsstundenzähler: Zählt die Zeit zwischen Events mit dem Wert 1 und addiert diese auf.
    private void HandleTimeDiffCounter(Counter counter, MqttPayload payload)
    {
        counter.LastTs ??= DateTime.Now;
        
        var payloadValue = Convert.ToInt32(payload.Value.ToString() ?? "0");

        var timeSpan = DateTime.Now.Subtract(counter.LastTs.Value);
        
        // prevent wrong counter value if messages from station were lost due to outage or failure
        if (counter.LastValue is 1 && counter.LastTs < DateTime.Now.AddMinutes(-5))
        {
            counter.LastValue = 0;
            logService.AddInfoNoSave(LogService.Event.ActorCounterRestart, $"Counter {counter.HardwareId}: LastValue set to 0 because last timestamp was too old (-5 minutes). Station outage?");
        }

        if (counter.LastValue is 1)
        {
            var sec = Convert.ToInt64(timeSpan.TotalSeconds);
            logger.LogDebug("counter={counter}, sec={sec}, lastValue={lastValue}, payload={payload}", counter.HardwareId, sec, counter.LastValue, payloadValue);
            counter.Count += sec;
        }
        
        counter.LastValue = payloadValue;
        counter.LastTs = DateTime.Now;
    }

    private void HandlePayloadValueAddCounter(Counter counter, MqttPayload payload)
    {
        var payloadValue = Convert.ToInt32(payload.Value.ToString() ?? "0");
        counter.Count += payloadValue;
        counter.LastValue = payloadValue;
        counter.LastTs = DateTime.Now;
    }
}