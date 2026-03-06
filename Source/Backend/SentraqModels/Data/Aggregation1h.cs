using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("vAggregation1h")]
public class Aggregation1h
{
    [MaxLength(36)]
    public required string HardwareId { get; init; }
    
    [Column("date_bin")]
    public DateTime DateBin { get; set; }
    
    [Column("sum")]
    public double Sum { get; set; }
}