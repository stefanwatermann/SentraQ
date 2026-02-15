using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using SentraqSimulator.Services;

namespace SentraqSimulator;

public sealed class Worker(
    IHostApplicationLifetime hostApplicationLifetime,
    ILogger<Worker> logger,
    IConfiguration config,
    CounterTestService counterTestService,
    LoadSimulatorService loadSimulatorService) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        var simulationDelayMSec = config.GetValue<int>("SimulationDelayMSec", 5000);
        
        try
        {
            if (!config.GetValue<bool>("SimulationEnabled") && 
                !config.GetValue<bool>("CounterEnabled"))
                throw new Exception("No simulation configured, please add either SimulationEnabled and/or CounterEnabled.");
            
            if (config.GetValue<bool>("SimulationEnabled"))
                loadSimulatorService.Init(simulationDelayMSec);
            
            if (config.GetValue<bool>("CounterEnabled"))
                counterTestService.Init(simulationDelayMSec);
            
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    if (config.GetValue<bool>("SimulationEnabled"))
                        loadSimulatorService.StartSimulation();

                    if (config.GetValue<bool>("CounterEnabled"))
                        counterTestService.StartSimulation();

                    await Task.Delay(simulationDelayMSec, stoppingToken);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Worker ERROR {0}", e);
                    logger.LogError(e, "Worker exception");
                }
            }
        }
        catch (Exception e)
        {
            Console.WriteLine("Worker CRITICAL {0}", e);
            logger.LogError(e, "Worker critical exception");
        }
        
        Console.WriteLine("Worker shutdown.");
    }
}