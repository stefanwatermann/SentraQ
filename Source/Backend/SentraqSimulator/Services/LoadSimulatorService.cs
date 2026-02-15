using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SentraqSimulator.Contexts;

namespace SentraqSimulator.Services;

public class LoadSimulatorService(
    ILogger<Worker> logger,
    IConfiguration config,
    WwpDatabaseContext dbContext
    ) : ISimulator
{
    private readonly List<MqttSenderService> _mqttClients = [];
    private int _totalSendCount = 0;
    private int _simulationDelayMSec;
    
    public void Init(int simulationDelayMSec)
    {
        _mqttClients.Clear();
        _totalSendCount = 0;
        _simulationDelayMSec = simulationDelayMSec;
        
        var components = dbContext
            .Components
            .Where(c => c.Station != null);

        foreach (var component in components)
        {
            _mqttClients.Add(new MqttSenderService(logger, config, component));
        }
    }

    public void StartSimulation()
    {
        foreach (var client in _mqttClients)
        {
            client.Execute();
            _totalSendCount++;
            logger.LogInformation("Total messages send: {_totalSendCount}", _totalSendCount);
            Thread.Sleep(_simulationDelayMSec);
        }
    }
}