namespace SentraqWatchdog.Models;

internal class WatchdogStation
{
    public string StationUid { get; set; }
    public string WatchdogHardwareId { get; set; }
    public DateTime LastReceivedTs { get; set; }
}