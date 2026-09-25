using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;
using SentraqModels.Extensions;

namespace SentraqCommon.Services;

public class NotificationService(
    ILogger<NotificationService> logger,
    LogService logService,
    SettingService settings,
    CacheService cacheService,
    MailService mailService,
    DatabaseContext dbContext)
{
    public void CheckAndSendNotifications()
    {
        var activeAlerts = dbContext
            .Alerts
            .Where(a => a.IsActive == "Y")
            .ToList();

        foreach (var alert in activeAlerts)
            SendAlertIfNeeded(alert);
    }
    
    private void SendAlertIfNeeded(Alert alert)
    {
        dbContext.Entry<Alert>(alert).Reload();
        
        var station = dbContext
            .Stations
            .First(s => s.Uid == alert.StationUid);
        
        var payloadsWithFault = dbContext
            .Components
            .Where(cm => cm.Station.Uid == station.Uid && cm.Type == "FL")
            .ToList()
            .Select(cm => cacheService.GetPayloadValueCacheByHardwareId(cm.HardwareId))
            .Where(c => c is { LastPayload: "1" });

        var componentsWithFaults = dbContext
            .Components
            .Where(c => payloadsWithFault
                .Select(p => p!.HardwareId)
                .Contains(c.HardwareId))
            .ToList();
        
        // Timestamp of last alert-mail for current station
        var lastMailTs = dbContext
            .Alerts
            .Where(a => a.StationUid == station.Uid)
            .Max(a => a.MailSendAt) ?? DateTime.MinValue;

        logger.LogDebug("lastMailTs={lastMailTs}", lastMailTs);

        if (alert is { ConfirmedAt: null, IsActive: "Y" } && !station.InMaintenance())
        {
            if (lastMailTs < DateTime.Now.AddMinutes(-settings.AlertMailResendMinutes))
            {
                if (settings.AlertSendEmail)
                {
                    SendAlertMailAsync(alert, station, componentsWithFaults);
                    alert.MailSendAt = DateTime.Now;
                    
                    logService.AddInfoNoSave(
                        LogService.Event.AlertAction,
                        $"E-Mail for alert #{alert.Id} and station {station.ShortName} ({station.Uid}) sent to {station.AlertReceiverEmailAddresses}");
                    
                    logger.LogDebug("dbContextId={ctxId}, uid={uid}", dbContext.ContextId, station.Uid);
                    dbContext.SaveChanges();
                }
                else
                    logger.LogWarning("E-mail alerts are disabled, no mail has been sent.");
            }
        }
    }
    
    private async void SendAlertMailAsync(Alert alert, Station station, List<Component> components)
    {
        if (string.IsNullOrWhiteSpace(station.AlertReceiverEmailAddresses))
        {
            logger.LogWarning(
                $"Cannot send alert mail, AlertReceiverEmailAddresses for station {station.Uid} is not set.");
            return;
        }

        await mailService.SendAsync(
            station.AlertReceiverEmailAddresses,
            ReplaceVars(settings.AlertMailSubject, alert, station, components[0]),
            ReplaceVars(settings.AlertMailBody, alert, station, components[0]));
    }

    private string ReplaceVars(string template, Alert alert, Station station, Component component)
    {
        return station.ReplaceVars(
                component.ReplaceVars(
                    alert.ReplaceVars(template)
                )
            )
            .Replace("{FrontendUrl}", settings.AlertMailFrontendUrl);
    }
}