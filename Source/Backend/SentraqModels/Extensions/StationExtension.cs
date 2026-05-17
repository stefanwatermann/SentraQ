using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class StationExtension
{
    public static bool InMaintenance(this Station station)
    {
        return station.MaintenanceActiveSinceTs.HasValue;
    }
}