using System.Text.Json;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Data;
using SentraqModels.Extensions;
using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler.Handler;

public class AlertMessageHandler(
    DatabaseContext dbContext,
    SettingService settings,
    MailService mailService,
    CacheService cacheService,
    LogService logService,
    ILogger<AlertMessageHandler> logger) : IMessageHandler
{
    public void HandleMessage(MqttPayload payload)
    {
        var faultValue = Convert.ToInt32(payload.Value.ToString());

        logger.LogDebug("{hid} Fault message received with value {v}", payload.Hid, faultValue);

        var component = cacheService.GetComponent(payload);
        if (component == null)
            return;

        if (!WaitFaultsReceived(payload.Hid, faultValue))
        {
            logger.LogDebug("{hid} MaxWaitFaultsReceived not reached, still waiting before sending alert", payload.Hid);
            return;
        }

        var alert = dbContext
            .Alerts
            .FirstOrDefault(a => a.StationUid == component.Station.Uid && a.IsActive == "Y");

        if (alert != null)
        {
            // ensure that latest data has been loaded
            dbContext.Entry(alert).Reload();
            logger.LogDebug("reloaded Alert={alert}", JsonSerializer.Serialize(alert));
        }

        if (faultValue != 0)
        {
            if (alert == null)
            {
                logger.LogInformation("No active Alert found for {hid}, creating new Alert.", payload.Hid);
                alert = new Alert()
                {
                    StationUid = component.Station.Uid,
                    FirstEventTs = DateTime.Now
                };
                dbContext.Alerts.Add(alert);
            }

            alert.IsActive = "Y";
            alert.LastEventTs = DateTime.Now;
        }
        else
        {
            if (alert != null)
                alert.IsActive = "N";
        }

        // Timestamp of last alert-mail for current station
        var lastMailTs = dbContext
            .Alerts
            .Where(a => a.StationUid == component.Station.Uid)
            .Max(a => a.MailSendAt) ?? DateTime.MinValue;

        logger.LogDebug("lastMailTs={lastMailTs}", lastMailTs);

        if (alert is { ConfirmedAt: null, IsActive: "Y" } && !component.Station.InMaintenance())
        {
            if (lastMailTs < DateTime.Now.AddMinutes(-settings.AlertMailResendMinutes))
            {
                if (settings.AlertSendEmail)
                {
                    SendAlertMailAsync(alert, component);
                    alert.MailSendAt = DateTime.Now;
                    logService.AddInfoNoSave(
                        LogService.Event.AlertAction,
                        $"E-Mail for alert #{alert.Id} and station {component.Station.ShortName} ({component.Station.Uid}) sent to {component.Station.AlertReceiverEmailAddresses}");
                }
                else
                    logger.LogWarning("E-mail alerts are disabled, no mail has been sent.");
            }
        }

        logger.LogDebug("dbContextId={ctxId}, hid={hid}", dbContext.ContextId, component.HardwareId);
        dbContext.SaveChanges();
    }

    private async void SendAlertMailAsync(Alert alert, Component component)
    {
        if (string.IsNullOrWhiteSpace(component.Station.AlertReceiverEmailAddresses))
        {
            logger.LogWarning(
                $"Cannot send alert mail, AlertReceiverEmailAddresses for station {component.Station.Uid} not set.");
            return;
        }

        await mailService.SendAsync(
            component.Station.AlertReceiverEmailAddresses,
            ReplaceVars(settings.AlertMailSubject, alert, component),
            ReplaceVars(settings.AlertMailBody, alert, component));
    }

    private string ReplaceVars(string template, Alert alert, Component component)
    {
        return component.Station.ReplaceVars(
                component.ReplaceVars(
                    alert.ReplaceVars(template)
                )
            )
            .Replace("{FrontendUrl}", settings.AlertMailFrontendUrl);
    }

    private static string GetTs(DateTime? ts, string defaultValue)
    {
        return ts.HasValue ? ts.Value.ToString("yyyy-MM-dd HH:mm:ss") : defaultValue;
    }

    private bool WaitFaultsReceived(string hid, int faultValue)
    {
        // reset counter if faultValue is 0
        if (faultValue == 0)
        {
            cacheService.SetFaultCounter(hid, 0);
            return true;
        }

        // increase fault counter
        var current = cacheService.GetFaultCounter(hid);
        cacheService.SetFaultCounter(hid, ++current);

        logger.LogDebug("AlertMessageHandler: AlertWaitFaultCount={current}", current);

        return current >= settings.AlertWaitFaultCount;
    }
}