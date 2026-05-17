namespace SentraqModels.Api;

public class Station
{
    public string? Uid { get; init; }
    
    public required string DisplayName { get; init; }
    
    public required string ShortName { get; init; }
        
    public required decimal Latitude { get; init; }
    public required decimal Longitude { get; init; }
    
    public required string Type { get; init; }
        
    public string? DisplayColor { get; init; }
    
    public int? DisplayOrder { get; init; }
    
    public string? WatchdogHardwareId { get; init; }
    
    public bool HasActiveAlert { get; init; } = false;
    
    public DateTime? MaintenanceActiveSinceTs { get; set; }
}