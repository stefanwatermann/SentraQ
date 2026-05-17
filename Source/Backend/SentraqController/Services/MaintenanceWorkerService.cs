using SentraqCommon.Context;
using SentraqCommon.Services;

namespace SentraqController.Services;

/// <summary>
/// Execute all kind of internal maintenance tasks,
/// like updating the services status-file, etc.
/// </summary>
/// <param name="logger"></param>
/// <param name="statusFileService"></param>
public class MaintenanceWorkerService(
    ILogger<MaintenanceWorkerService> logger,
    StatusFileService statusFileService,
    MailService mailService,
    StationService stationService
) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            // Update status-file every 10 seconds 
            if (DateTime.Now.Second % 10 == 0)
                statusFileService.Keepalive("Controller");

            // check every 60 seconds if alert for "maintenance mode still active" needs to be sent for any station
            if (DateTime.Now.Second == 0)
                stationService.EvaluateStationsMaintenanceModeActiveStatus();

            await Task.Delay(1000, stoppingToken);
        }
    }
}