using SentraqCommon.Services;

namespace SentraqController.Services;

/// <summary>
/// Execute all kind of internal maintenance tasks,
/// like updating the services status-file, etc.
/// </summary>
/// <param name="statusFileService"></param>
public class MaintenanceWorkerService(
    CacheService cacheService,
    StatusFileService statusFileService,
    StationService stationService,
    NotificationService notificationService
) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        statusFileService.WriteVersionFile("Controller");
        
        while (!stoppingToken.IsCancellationRequested)
        {
            // Update status-file every 10 seconds 
            if (DateTime.Now.Second % 10 == 0)
                statusFileService.Keepalive("Controller");

            // check every 60 seconds if alert for "maintenance mode still active" needs to be sent for any station
            if (DateTime.Now.Second == 0)
                stationService.EvaluateAndAlertStationMaintenanceModeActive();
            
            // re-init cached components every 60 seconds
            if (DateTime.Now.Second == 0)
                cacheService.ReInit();
            
            // check for notifications (e.g. Alert) and send alerts if needed
            if (DateTime.Now.Second == 0)
                notificationService.CheckAndSendNotifications();

            await Task.Delay(1000, stoppingToken);
        }
    }
}