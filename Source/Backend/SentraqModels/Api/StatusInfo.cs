namespace SentraqModels.Api;

public class StatusInfo
{
    public string? ApiVersion { get; set; }
    public string? ControllerVersion { get; set; }
    public bool ControllerUp { get; set; }
    public string? WatchdogVersion { get; set; }
    public bool WatchdogUp { get; set; }
    public string? LastLogs { get; set; }
}