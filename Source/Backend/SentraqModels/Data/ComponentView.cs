using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("vComponentLast")]
public class ComponentView
{
    [Key]
    [MaxLength(36)]
    public required string HardwareId { get; init; }
    
    [MaxLength(250)]
    public required string DisplayName { get; init; }
    
    [MaxLength(50)]
    public required string ShortName { get; init; }
        
    [MaxLength(20)]
    public required string Type { get; init; }
    
    [MaxLength(50)]
    public string? DisplayUnit { get; init; }
    
    public required int MinValue { get; init; }
    
    public required int MaxValue { get; init; }
    
    public int? DisplayOrder { get; set; }
    
    public long StationId { get; init; }
    
    [ForeignKey("StationId")]
    public Station Station { get; init; }
    
    public required string StationUid { get; init; }
    
    public string? LastPayload { get; init; }
    
    public DateTime? LastReceivedTs { get; init; }
    
    public DateTime? FirstReceivedTs { get; init; }
}