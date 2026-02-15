using System.Text.Json;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Data;
using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler.Handler;

public class AlertMessageHandler(
    DatabaseContext dbContext,
    SettingService settings,
    MailService mailService,
    CacheService componentCacheService,
    ILogger<AlertMessageHandler> logger) : IMessageHandler
{
    public void HandleMessage(MqttPayload payload)
    {
        var component = componentCacheService.GetComponent(payload);
        if (component == null) 
            return;
        
        var alertValue = Convert.ToInt32(payload.Value.ToString());
        
        logger.LogDebug("AlertMessageHandler: {hid} Fault message received with value {v}", payload.Hid, alertValue);
        
        var alert = dbContext
            .Alerts
            .FirstOrDefault(a => a.StationUid == component.Station.Uid && a.IsActive == "Y");

        if (alert != null)
        {
            // ensure that latest data has been loaded
            dbContext.Entry(alert).Reload();
            logger.LogDebug("AlertMessageHandler: reloaded Alert={alert}", JsonSerializer.Serialize(alert));
        }

        if (alertValue != 0)
        {
            if (alert == null)
            {
                logger.LogDebug("AlertMessageHandler: {hid} No active Alert found, creating new Alert.", payload.Hid);
                
                // create new (active) alert
                alert = new Alert()
                {
                    StationUid = component.Station.Uid,
                    IsActive = "Y",
                    FirstEventTs = DateTime.Now
                };
                dbContext.Alerts.Add(alert);
            }

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
        
        logger.LogDebug("AlertMessageHandler: lastMailTs={lastMailTs}", lastMailTs);
        
        if (alert is { ConfirmedAt: null, IsActive: "Y" })
        {
            if (lastMailTs < DateTime.Now.AddMinutes(-settings.AlertMailResendMinutes))
            {
                SendAlertMail(alert, component);
            }
        }
        
        logger.LogDebug("AlertMessageHandler: dbContextId={ctxid}, hid={hid}", dbContext.ContextId, component.HardwareId);
        dbContext.SaveChanges();
    }

    private void SendAlertMail(Alert alert, Component component)
    {
        // start async, weil sonst blockiert es den MqttSubscriber
        mailService.Send(
            component.Station.AlertReceiverEmailAddresses, 
            ReplaceVars(settings.AlertMailSubject, alert, component),
            ReplaceVars(settings.AlertMailBody, alert, component));
        
        alert.MailSendAt = DateTime.Now;
        
        logger.LogInformation("AlertMessageHandler: Mail sent to {to}", component.Station.AlertReceiverEmailAddresses);
    }

    private string ReplaceVars(string variable, Alert alert, Component component)
    {
        return variable
            .Replace("{FrontendUrl}", settings.AlertMailFrontendUrl)
            .Replace("{Station.Uid}", component.Station.Uid)
            .Replace("{Station.ShortName}", component.Station.ShortName)
            .Replace("{Station.DisplayName}", component.Station.DisplayName)
            .Replace("{Component.HardwareId}", component.HardwareId)
            .Replace("{Component.DisplayName}", component.DisplayName)
            .Replace("{Component.ShortName}", component.ShortName)
            .Replace("{Alert.FirstEventTs}", GetTs(alert.FirstEventTs, ""))
            .Replace("{Alert.LastEventTs}", GetTs(alert.LastEventTs, ""));
    }

    private string GetTs(DateTime? ts, string defaultValue)
    {
        return ts.HasValue ? ts.Value.ToString("yyyy-MM-dd HH:mm:ss") : defaultValue;
    }
}