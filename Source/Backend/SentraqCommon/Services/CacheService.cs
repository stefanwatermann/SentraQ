using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;
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
    private List<Component> _knownComponents = [];
    private List<Counter> _knownCounters = [];

    public void Init()
    {
        // read all components at service startup
        _knownComponents = dbContext
            .Components
            .AsNoTracking()
            .Include((c => c.Station))
            .ToList();
        
        // read all counter at service startup
        _knownCounters = dbContext
            .Counters
            .AsNoTracking()
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
        
        logger.LogDebug("Payload invalid, unknown hardware ID: {payload}", payload.Hid);
        return false;
    }
    
    public bool CounterExists(MqttPayload payload)
    {
        if (GetCounter(payload) != null)
            return true;
        logger.LogDebug("Payload invalid, unknown hardware ID: {payload}", payload.Hid);
        return false;
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
}