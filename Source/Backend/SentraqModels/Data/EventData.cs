using System.ComponentModel.DataAnnotations;

namespace SentraqModels.Data;

public class EventData
{
    [Key]
    public long Id { get; init; }
    
    [MaxLength(36)]
    public required string HardwareId { get; init; }
    
    public DateTime CreateTs { get; init; }
    
    public DateTime ReceivedTs { get; set; }
    
    [MaxLength(1000)]
    public string? Payload { get; init; }
}