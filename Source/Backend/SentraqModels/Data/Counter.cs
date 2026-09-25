using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using SentraqModels.Enums;

namespace SentraqModels.Data;

[Table("Counter")]
public class Counter
{
    [Key] 
    public long Id { get; init; }

    [MaxLength(36)] 
    public required string HardwareId { get; init; } = string.Empty;
    
    public DateTime? LastTs { get; set; }
    
    public int LastValue { get; set; } = 0;
    
    public long Count { get; set; } = 0;
    
    public bool Removed { get; set; }
    
    public bool Visible { get; set; }
    
    public CounterType Type { get; set; }
}