namespace SentraqModels.Api;

public class StatusInfo
{
    public string? ApiVersion { get; set; }
    public string? ControllerVersion { get; set; }
    public string? LastLogs { get; set; }
    public bool ControllerUp { get; set; }
}