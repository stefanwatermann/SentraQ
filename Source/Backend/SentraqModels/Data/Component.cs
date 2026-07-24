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
    public required string DisplayName { get; set; }
    
    [MaxLength(50)]
    public required string ShortName { get; set; }
        
    [MaxLength(20)]
    public required string Type { get; set; }
    
    [MaxLength(50)]
    public string? DisplayUnit { get; set; }
    
    public required int MinValue { get; set; }
    
    public required int MaxValue { get; set; }
    
    public int? DisplayOrder { get; set; }
    
    [MaxLength(50)]
    public string? AdjustmentFunction { get; set; }
    
    public bool Removed { get; set; }
    
    public bool Visible { get; set; }
}