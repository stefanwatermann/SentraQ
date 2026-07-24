using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class AlertExtensions
{
    public static string ReplaceVars(this Alert alert, string template)
    {
        return template
            .Replace("{Alert.ConfirmedAt}", GetTs(alert.ConfirmedAt, ""))
            .Replace("{Alert.ConfirmedBy}", alert.ConfirmedBy)
            .Replace("{Alert.FirstEventTs}", GetTs(alert.FirstEventTs, ""))
            .Replace("{Alert.LastEventTs}", GetTs(alert.LastEventTs, ""));
    }
    
    private static string GetTs(DateTime? ts, string defaultValue)
    {
        return ts.HasValue ? ts.Value.ToString("yyyy-MM-dd HH:mm:ss") : defaultValue;
    }
}