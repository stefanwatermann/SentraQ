using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqModels.Data;

namespace SentraqCommon.Services;

/// <summary>
/// Business related log messages, written to database table Log.
/// </summary>
/// <param name="logger"></param>
/// <param name="dbContext"></param>
public class LogService(
    ILogger<CacheService> logger,
    DatabaseContext dbContext)
{
    public enum Severity
    {
        Info,
        Warning,
        Error
    }

    public enum Event
    {
        UserLogon,
        UserPasswordResetRequested,
        UserPasswordChanged,
        AlertAction,
        ActorCounterRestart
    }

    public void AddInfo(Event evt, string msg = "")
    {
        Add(evt, Severity.Info, msg);
    }
    
    public void Add(Event evt, Severity svt = Severity.Info, string msg = "")
    {
        var safeMsg = msg.Sanitize(1000);
        
        var log = new Log()
        {
            LogTs = DateTime.Now,
            Severity = TranslateSeverity(svt),
            Event = TranslateEvent(evt),
            Message = safeMsg
        };
        
        dbContext.Logs.Add(log);
        
        logger.LogInformation("LogService: message added: {evt}, {msg}", evt, safeMsg);
    }

    private string TranslateSeverity(Severity severity)
    {
        var s = Enum.GetName(severity) ?? string.Empty;
        return s[0].ToString();
    }

    private string TranslateEvent(Event evt)
    {
        var elems = Enum.GetName(evt).SplitCamelCase();
        if (elems.Length > 2)
            return $"{elems[0]}:{elems[1]}:{string.Join("", elems[2..])}";
        else if (elems.Length == 2)
            return $"{elems[0]}:{elems[1]}";
        else if (elems.Length == 1)
            return $"{elems[0]}";
        else
            return "unknown";
    }
}