namespace SentraqWatchdog.Models;

internal class WatchdogStation
{
    public string StationUid { get; init; }
    public string WatchdogHardwareId { get; init; }
    public DateTime LastReceivedTs { get; init; }
}