using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace SentraqModels.Data;

[Table("Component")]
public class Component
{
    [Key]
    public long Id { get; init; }
    
    public long StationId { get; init; }
    
    [ForeignKey("StationId")]
    public Station Station { get; init; }
        
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
}