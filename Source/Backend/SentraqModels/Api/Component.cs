namespace SentraqModels.Api;

public class Component
{
    public required string HardwareId { get; init; }
    
    public required string StationUid { get; init; }
    
    public required string DisplayName { get; init; }
    
    public required string ShortName { get; init; }
    
    public required string Type { get; init; }
    
    public object? CurrentValue { get; init; }
    
    public DateTime? LastReceivedTs { get; init; }
    public DateTime? FirstReceivedTs { get; init; }
    
    public string? DisplayUnit { get; init; }
    
    public required int MinValue { get; init; }
    
    public required int MaxValue { get; init; }
    
    public int? DisplayOrder { get; init; }
}