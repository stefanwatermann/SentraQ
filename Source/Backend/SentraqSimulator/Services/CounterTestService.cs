using System.Security.Cryptography;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SentraqSimulator.Contexts;
using SentraqModels.Data;
using SentraqModels.Mqtt;

namespace SentraqSimulator.Services;

public class CounterTestService(
    ILogger<Worker> logger,
    IConfiguration config,
    WwpDatabaseContext dbContext) : ISimulator
{
    private List<Counter> _counters = [];
    private List<Tuple<Counter, byte[]>> _counterData = [];

    private const int _sendDelayMSec = 60000;
    private const int _counterCount = 840;
    private bool _simulationActive = false;
    
    public void Init(int simulationDelayMSec)
    {
        _counters = dbContext
            .Counters
            .AsNoTracking()
            .ToList();
        
        // prepare test data
        foreach (var counter in _counters)
        {
            var cd = new Tuple<Counter, byte[]>(counter, CreateCounterData(_counterCount));
            var totalSecs = cd.Item2.Where(b => b == 1).Sum(b => b) * _sendDelayMSec / 1000;
            Console.WriteLine($"Expected seconds for {cd.Item1.HardwareId} = {totalSecs}");
            _counterData.Add(cd);
        }
    }

    public void StartSimulation()
    {
        if (_simulationActive) 
            return;
        
        foreach (var cd in _counterData)
        {
            StartSimulationAsync(cd);
        }

        _simulationActive = true;
    }

    private async void StartSimulationAsync(Tuple<Counter, byte[]> cd)
    {
        await Task.Run(() =>
        {
            var component = dbContext.Components.FirstOrDefault(c => c.HardwareId == cd.Item1.HardwareId) ?? 
                            throw new InvalidOperationException($"Component {cd.Item1.HardwareId} not found");
            
            var mqttSender = new MqttSenderService(logger, config, component);
            var c = 0;
            foreach (var b in cd.Item2)
            {
                var payload = new MqttPayload()
                {
                    Hid = component.HardwareId,
                    TS = DateTime.Now,
                    Value = b
                };
                mqttSender.SendAsync(payload);
                c += b;
                Console.WriteLine($"{DateTime.Now:HH:mm:ss} payload {b} sent to {component.HardwareId} => {c * _sendDelayMSec / 1000}.");
                Thread.Sleep(_sendDelayMSec);
            }
        });
    }
    
    private byte[] CreateCounterData(int counter)
    {
        var counterData = new List<byte>();
        var rand = new Random();
        
        for (var i = 0; i < counter; i++)
        {
            counterData.Add((byte)rand.Next(0, 2));
        }
        
        return counterData.ToArray();
    }
}