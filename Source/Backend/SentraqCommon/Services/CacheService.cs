using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;
using SentraqModels.Internal;
using SentraqModels.Mqtt;

namespace SentraqCommon.Services;

/// <summary>
/// Keeps components and counters in cache.
/// </summary>
/// <param name="logger"></param>
/// <param name="dbContext"></param>
public class CacheService(
    ILogger<CacheService> logger,
    DatabaseContext dbContext)
{
    private readonly Dictionary<string, int> _faultCounter = new();
    private List<Component> _knownComponents = [];
    private List<Counter> _knownCounters = [];
    private List<PayloadLastValueCache> _payloadValueCache = [];

    // Cache Components, Counters and last Payloads of Components
    public void Init()
    {
        // read all components 
        InitComponentCache();

        // read all counter 
        InitCounterCache();
        
        // read last payloads
        InitPayLoadValueCache();
        
        logger.LogInformation($"CacheService initialized for {_knownComponents.Count} components/payloads and {_knownCounters.Count} counters.");
    }
    
    // Reinit cached Components and Counters, but not Payloads (due to performance).
    public void ReInit()
    {
        // read all components 
        InitComponentCache();

        // read all counter 
        InitCounterCache();
        
        logger.LogInformation($"CacheService reinitialized for {_knownComponents.Count} components and {_knownCounters.Count} counters.");
    }

    private void InitPayLoadValueCache()
    {
        _payloadValueCache = dbContext
            .ComponentsView
            .AsNoTracking()
            .Select(c => new PayloadLastValueCache()
            {
                HardwareId = c.HardwareId,
                LastPayload = c.LastPayload ?? string.Empty,
                LastChangedTs = c.LastReceivedTs ?? DateTime.MinValue,
            })
            .ToList();
    }
    
    private void InitCounterCache()
    {
        _knownCounters = dbContext
            .Counters
            .AsNoTracking()
            .ToList();
    }

    private void InitComponentCache()
    {
        _knownComponents = dbContext
            .Components
            .AsNoTracking()
            .Include((c => c.Station))
            .Where(c => c.Removed == false && c.Station.Removed == false)
            .ToList();
    }

    public Component? GetComponent(MqttPayload payload)
    {
        return _knownComponents
            .FirstOrDefault(c => c.HardwareId == payload.Hid);
    }
    
    public Component? GetComponent(string hardwareId)
    {
        return _knownComponents
            .FirstOrDefault(c => c.HardwareId == hardwareId);
    }
    
    public bool ComponentExists(MqttPayload payload)
    {
        if (GetComponent(payload) != null)
            return true;
        
        logger.LogDebug("Payload invalid, unknown component hardware ID: {payload}", payload.Hid);
        return false;
    }
    
    public bool CounterExists(MqttPayload payload)
    {
        return GetCounter(payload) != null;
    }
    
    public Counter? GetCounter(MqttPayload payload)
    {
        return _knownCounters
            .FirstOrDefault(c => c.HardwareId == payload.Hid);
    }
    
    public Counter? GetCounter(string hardwareId)
    {
        return _knownCounters
            .FirstOrDefault(c => c.HardwareId == hardwareId);
    }

    public void SetFaultCounter(string hid, int value)
    {
        _faultCounter[hid] = value;
    }

    public int GetFaultCounter(string hid)
    {
        return _faultCounter.GetValueOrDefault(hid, 0);
    }

    public void SetPayloadValueCache(MqttPayload payload)
    {
        var cachedPayloadValue = _payloadValueCache
            .FirstOrDefault(c => c.HardwareId == payload.Hid);
        
        if (cachedPayloadValue is null)
        {
            _payloadValueCache.Add(new PayloadLastValueCache()
            {
                HardwareId = payload.Hid,
                LastPayload = Convert.ToString(payload.Value) ?? string.Empty,
                LastChangedTs = DateTime.Now
            });
        }
        else
        {
            cachedPayloadValue.LastPayload = Convert.ToString(payload.Value) ?? string.Empty;
            cachedPayloadValue.LastChangedTs = DateTime.Now;
        }
    }
    
    public PayloadLastValueCache? GetPayloadValueCacheByHardwareId(string hardwareId)
    {
        return _payloadValueCache.FirstOrDefault(c => c.HardwareId == hardwareId);
    }
}