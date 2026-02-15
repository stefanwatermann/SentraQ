using Microsoft.Extensions.Hosting;

namespace SentraqWatchdog.Services;

/// <summary>
/// Singulärer Watchdog Service.
/// </summary>
public class WatchdogWorkerService(
    WatchdogService watchdogService
    ) : BackgroundService
{
    private const int _watchdogIntervalSeconds = 60;

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            watchdogService.Watch();
            await Task.Delay(_watchdogIntervalSeconds * 1000, stoppingToken);
        }
    }
}