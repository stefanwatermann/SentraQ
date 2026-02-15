namespace SentraqModels.Api;

public class EventData
{
    public required string HardwareId { get; init; }
    
    public DateTime CreateTs { get; init; }
    
    public DateTime ReceivedTs { get; set; }
    
    public string? Payload { get; init; }
}