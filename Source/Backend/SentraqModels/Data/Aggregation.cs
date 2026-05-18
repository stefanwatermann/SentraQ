using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

public class Aggregation
{
    [MaxLength(36)]
    public required string HardwareId { get; init; }
    
    [Key]
    [Column("date_bin")]
    public DateTime DateBin { get; init; }
    
    [Column("value")]
    public double Value { get; init; }
}