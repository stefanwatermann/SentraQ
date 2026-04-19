namespace SentraqModels.Api;

public class Log
{
    public required DateTime LogTs { get; set; }
    
    public required string EventType { get; set; } = string.Empty;
    public string Severity { get; set; } = string.Empty;
    public string? Message { get; set; } = string.Empty;
}