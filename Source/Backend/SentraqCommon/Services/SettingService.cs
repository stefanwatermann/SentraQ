using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;

namespace SentraqCommon.Services;

public class SettingService
{
    private readonly DatabaseContext _dbContext;
    
    public string ControllerMqttBrokerHostname { get; private set; }
    public int ControllerMqttBrokerPort { get; private set; }
    public string ControllerMqttBrokerUsername { get; private set; }
    public string ControllerMqttBrokerPassword { get; private set; }
    public string ControllerMqttClientTopic { get; private set; }
    public string ControllerFrontendApiUrl { get; private set; }
    public string ControllerFrontendApiApiAuthKey { get; private set; }
    
    public string MailServerName { get; private set; }
    public int MailServerPort { get; private set; }
    public string MailServerUser { get; private set; }
    public string MailServerPassword { get; private set; }
    
    public string AlertMailFrom { get; private set; }
    public string AlertMailSubject { get; private set; }
    public string AlertMailBody { get; private set; }
    public string AlertMailFrontendUrl { get; private set; }
    public int AlertMailResendMinutes { get; private set; }
    
    public int WatchdogAlertAfterSeconds { get; private set; }
    
    public string ApiRequiredAuthKey { get; private set; }
    
    public string PasswordResetMailBody { get; private set; }
    public string PasswordResetMailSubject { get; private set; }
    public string PasswordResetMailFrom { get; private set; }
    public int PasswordResetCodeLifetimeMinutes { get; private set; }
    public string PasswordResetCodeSalt { get; private set; }
    public string PasswordResetFrontendUrl { get; private set; }

    public SettingService(DatabaseContext dbContext)
    {
        _dbContext = dbContext;
        
        ControllerMqttBrokerHostname = GetValue<string>("Controller:Mqtt:Broker:Hostname");
        ControllerMqttBrokerPort = GetValue<int>("Controller:Mqtt:Broker:Port");
        ControllerMqttBrokerUsername = GetValue<string>("Controller:Mqtt:Broker:Username");
        ControllerMqttBrokerPassword = GetValue<string>("Controller:Mqtt:Broker:Password");
        ControllerMqttClientTopic = GetValue<string>("Controller:Mqtt:ClientTopic");
        ControllerFrontendApiUrl = GetValue<string>("Controller:FrontendApi:Url");
        ControllerFrontendApiApiAuthKey = GetValue<string>("Controller:FrontendApi:ApiAuthKey");
        
        MailServerName = GetValue<string>("Mail:Server:Name");
        MailServerPort = GetValue<int>("Mail:Server:Port");
        MailServerUser = GetValue<string>("Mail:Server:User");
        MailServerPassword = GetValue<string>("Mail:Server:Password");
        
        AlertMailFrom = GetValue<string>("Alert:Mail:From", "");
        AlertMailSubject = GetValue<string>("Alert:Mail:Subject", "Eine Störung liegt vor.");
        AlertMailBody = GetValue<string>("Alert:Mail:Body", "Eine Störung liegt vor.");
        AlertMailFrontendUrl = GetValue<string>("Alert:Mail:FrontendUrl", "<todo>");
        AlertMailResendMinutes = GetValue<int>("Alert:Mail:ResendMinutes", 15);
        
        WatchdogAlertAfterSeconds = GetValue<int>("Watchdog:Alert:AfterSeconds", 300);
        
        ApiRequiredAuthKey = GetValue<string>("Api:RequiredAuthKey");
        
        PasswordResetMailFrom = GetValue<string>("PasswordReset:Mail:From", "<todo>");
        PasswordResetMailBody = GetValue<string>("PasswordReset:Mail:Body", "<div>Klicken Sie nachstehenden Link um Ihr Passwort mit Ihrem Passwort-Code {PasswordResetCode} zu ändern.</div><div><a href='{PasswordResetLink}'>Passwort jetzt ändern...</a></div>"); PasswordResetMailSubject = GetValue<string>("PasswordReset:Mail:Subject", "Passwort zurücksetzen");
        PasswordResetCodeLifetimeMinutes = GetValue<int>("PasswordReset:Code:LifetimeMinutes", 30);
        PasswordResetCodeSalt = GetValue<string>("PasswordReset:Code:Salt", "<todo>");
        PasswordResetFrontendUrl = GetValue<string>("PasswordReset:FrontendUrl");
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