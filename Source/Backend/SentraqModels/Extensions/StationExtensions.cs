using System.Text.Json.Serialization;
using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class StationExtensions
{
    public static bool InMaintenance(this Station station)
    {
        return station.MaintenanceActiveSinceTs.HasValue;
    }
    
    public static string ReplaceVars(this Station station, string template)
    {
        return template
            .Replace("{Station.Uid}", station.Uid)
            .Replace("{Station.ShortName}", station.ShortName)
            .Replace("{Station.DisplayName}", station.DisplayName);
    }
}