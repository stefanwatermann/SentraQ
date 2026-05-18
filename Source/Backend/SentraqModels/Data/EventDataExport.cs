using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("vEventDataExport")]
public class EventDataExport
{
    public required string StationName { get; init; }
    
    public required string StationUid { get; init; }
    
    public required string ComponentName { get; init; }
    
    public required string HardwareId { get; init; }
    
    public required string ComponentType { get; init; }
    
    [Key]
    public required DateTime Received { get; init; }
    
    public string? Unit { get; init; }
    
    public double Value { get; init; }
}