using Microsoft.Extensions.Hosting;
using SentraqCommon.Services;

namespace SentraqWatchdog.Services;

/// <summary>
/// Singulärer Watchdog Service.
/// </summary>
public class WatchdogWorkerService(
    WatchdogService watchdogService,
    StatusFileService statusFileService
    ) : BackgroundService
{
    private const int _watchdogIntervalSeconds = 60;

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            // Update status-file every 10 seconds 
            if (DateTime.Now.Second % 10 == 0)
                statusFileService.Keepalive("Watchdog");
            
            // execute Watchdog service
            if (DateTime.Now.Second % _watchdogIntervalSeconds == 0)
                watchdogService.Watch();
            
            await Task.Delay(1000, stoppingToken);
        }
    }
}