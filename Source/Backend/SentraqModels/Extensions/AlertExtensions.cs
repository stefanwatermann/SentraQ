// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
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