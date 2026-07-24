using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;
using SentraqCommon.Exceptions;

namespace SentraqCommon.Services;

/// <summary>
/// Provides access to all application-settings stored in the Setting table.
/// Used by all components.
/// </summary>
public class SettingService
{
    private readonly DatabaseContext _dbContext;
    
    [Required]
    [Description("Hostname of the MQTT broker.")]
    public string ControllerMqttBrokerHostname { get; private set; }
    
    [Description("TCP port of the MQTT broker. Default: 8883")]
    public int ControllerMqttBrokerPort { get; private set; }
    
    [Required]
    [Description("Username used to connect to the MQTT broker.")]
    public string ControllerMqttBrokerUsername { get; private set; }
    
    [Required]
    [Description("Encrypted password of the user used to connect to the MQTT broker. ")]
    public string ControllerMqttBrokerPassword { get; private set; }
    
    [Required]
    [Description("MQTT topic used by the stations to send message and used by the controller to read these messages. E.g. /client/send/[guid].")]
    public string ControllerMqttClientTopic { get; private set; }
    
    [Description("URL of the frontend api used to make realtiem updates of received data. Default: http://localhost:9004/api/update/realtime/")]
    public string ControllerFrontendApiUrl { get; private set; }
    
    [Required]
    [Description("API-key used to connect to the frontend api, as defined by the frontend in its local config file (App.StatusService.ApiKey).")]
    public string ControllerFrontendApiApiAuthKey { get; private set; }
    
    [Required]
    [Description("Hostname of the SMTP server used to send alert or status emails.")]
    public string MailServerName { get; private set; }
    
    [Description("TCP port of the SMTP server. Default: 465")]
    public int MailServerPort { get; private set; }
    
    [Required]
    [Description("Username used to authenticate to the SMTP server.")]
    public string MailServerUser { get; private set; }
    
    [Required]
    [Description("Encrypted password used to authenticate to the SMTP server.")]
    public string MailServerPassword { get; private set; }
    
    [Required()]
    [Description("SMTP address of the sender of e-mails used for all e-mails sent by the system (e.g. alert e-mails).")]
    public string AlertMailFrom { get; private set; }
    
    [Description("Template for the subject of e-mail messages. Can contain valiables to be replaced (see RepaceVars extension methods).")]
    public string AlertMailSubject { get; private set; }
    
    [Description("Template for the body of e-mail messages. Can contain valiables to be replaced (see RepaceVars extension methods).")]
    public string AlertMailBody { get; private set; }
    
    [Required()]
    [Description("Url used in alert e-mails to allow users to open the frontend website. E.g. https://www.sentraq.de/#station")]
    public string AlertMailFrontendUrl { get; private set; }
    
    [Description("Minutes to wait before resending mail for an unconfirmed alert. Default: 15")]
    public int AlertMailResendMinutes { get; private set; }
    
    [Description("Number of fault messages to receive before sending an alert mail. Default: 1")]
    public int AlertWaitFaultCount { get; private set; }
    
    [Description("Enable/Disable e-mail alerting. Default: True")]
    public bool AlertSendEmail { get; private set; }
    
    
    public int MaintenanceActiveAlertAfterHours { get; private set; }
    public string MaintenanceActiveMailAlertMessage { get; private set; }
    public string MaintenanceActiveMailAlertSubject { get; private set; }
    
    public int WatchdogAlertAfterSeconds { get; private set; }
    
    [Required()]
    public string ApiRequiredAuthKey { get; private set; }
    
    public string PasswordResetMailBody { get; private set; }
    public string PasswordResetMailSubject { get; private set; }
    
    [Required()]
    public string PasswordResetMailFrom { get; private set; }
    public int PasswordResetCodeLifetimeMinutes { get; private set; }
    
    [Required()]
    public string PasswordResetCodeSalt { get; private set; }
    
    [Required()]
    public string PasswordResetFrontendUrl { get; private set; }
    
    public string PasskeyRequestMailBody { get; private set; }
    public string PasskeyRequestMailSubject { get; private set; }
    
    [Required()]
    public string PasskeyRequestFrontendUrl { get; private set; }

    public SettingService(
        DatabaseContext dbContext)
    {
        _dbContext = dbContext;
        
        ControllerMqttBrokerHostname = GetValue<string>("Controller:Mqtt:Broker:Hostname");
        ControllerMqttBrokerPort = GetValue<int>("Controller:Mqtt:Broker:Port", 8883);
        ControllerMqttBrokerUsername = GetValue<string>("Controller:Mqtt:Broker:Username");
        ControllerMqttBrokerPassword = GetValue<string>("Controller:Mqtt:Broker:Password");
        ControllerMqttClientTopic = GetValue<string>("Controller:Mqtt:ClientTopic");
        ControllerFrontendApiUrl = GetValue<string>("Controller:FrontendApi:Url", "http://localhost:9004/api/update/realtime/");
        ControllerFrontendApiApiAuthKey = GetValue<string>("Controller:FrontendApi:ApiAuthKey");
        
        MailServerName = GetValue<string>("Mail:Server:Name");
        MailServerPort = GetValue<int>("Mail:Server:Port", 465);
        MailServerUser = GetValue<string>("Mail:Server:User");
        MailServerPassword = GetValue<string>("Mail:Server:Password");
        
        AlertMailFrom = GetValue<string>("Alert:Mail:From");
        AlertMailSubject = GetValue<string>("Alert:Mail:Subject", "Eine Störung liegt vor.");
        AlertMailBody = GetValue<string>("Alert:Mail:Body", "<div>Es ist eine Störung in Station {Station.DisplayName} aufgetreten.</div>");
        AlertMailFrontendUrl = GetValue<string>("Alert:Mail:FrontendUrl");
        AlertMailResendMinutes = GetValue<int>("Alert:Mail:ResendMinutes", 15);
        AlertWaitFaultCount = GetValue<int>("Alert:Mail:MaxFaultCount", 1);
        AlertSendEmail = GetValue<bool>("Alert:Send:Mail", true);
        
        MaintenanceActiveAlertAfterHours = GetValue<int>("Maintenance:Active:AlertAfterHours", 12);
        MaintenanceActiveMailAlertMessage = GetValue<string>("Maintenance:Active:MailAlertMessage", "<div>Hinweis: Station {Station.DisplayName} befindet sich seit {Maintenance.Hours} Stunden im Wartungsmodus.</div>");
        MaintenanceActiveMailAlertSubject = GetValue<string>("Maintenance:Active:MailAlertSubject", "Wartungsmodus für Station {Station.DisplayName} aktiv");
        
        WatchdogAlertAfterSeconds = GetValue<int>("Watchdog:Alert:AfterSeconds", 300);
        
        ApiRequiredAuthKey = GetValue<string>("Api:RequiredAuthKey");
        
        PasswordResetMailFrom = GetValue<string>("PasswordReset:Mail:From");
        PasswordResetMailBody = GetValue<string>("PasswordReset:Mail:Body", "<div>Klicken Sie nachstehenden Link um Ihr Passwort mit Ihrem Passwort-Code {PasswordResetCode} zu ändern.</div><div><a href='{PasswordResetLink}'>Passwort jetzt ändern...</a></div>"); 
        PasswordResetMailSubject = GetValue<string>("PasswordReset:Mail:Subject", "Passwort zurücksetzen");
        PasswordResetCodeLifetimeMinutes = GetValue<int>("PasswordReset:Code:LifetimeMinutes", 30);
        PasswordResetCodeSalt = GetValue<string>("PasswordReset:Code:Salt");
        PasswordResetFrontendUrl = GetValue<string>("PasswordReset:FrontendUrl");
        
        PasskeyRequestMailBody = GetValue<string>("PasskeyRequest:Mail:Body", "<div>Klicken Sie nachstehenden Link um Ihren individuellen Passkey mit dem Code {PasskeyCode} zu erzeugen.</div><div><a href='{PasskeyLink}'>Passkey jetzt erzeugen...</a></div>"); 
        PasskeyRequestMailSubject = GetValue<string>("PasskeyRequest:Mail:Subject", "Passkey anlegen");
        PasskeyRequestFrontendUrl = GetValue<string>("PasskeyRequest:FrontendUrl");
        
    }

    /// <summary>
    /// Validates that all "required" settings have a value.
    /// </summary>
    /// <exception cref="MissingRequiredSettingException">Lists missing settings.</exception>
    public void Validate()
    {
        var missingSettings = new List<string>();
        
        // validate every single setting
        foreach (var property in GetType().GetProperties())
        {
            var name = property.Name;
            var value = property.GetValue(this)?.ToString();
            var required = property
                .CustomAttributes
                .FirstOrDefault(a => a.AttributeType == typeof(RequiredAttribute)) != null;
            
            if (required && string.IsNullOrWhiteSpace(value))
                missingSettings.Add(name);
        }

        if (missingSettings.Count > 0)
            throw new MissingRequiredSettingException(missingSettings.ToArray());
    }
    
    private T GetValue<T>(string key, T defaultValue = default)
    {
        var s = _dbContext
            .Settings
            .AsNoTracking()
            .ToList()
            .FirstOrDefault(s => s.Key == key)?.Value;
        
        if (!string.IsNullOrWhiteSpace(s))
            return (T) Convert.ChangeType(s, typeof(T));
        
        return defaultValue;
    }
}