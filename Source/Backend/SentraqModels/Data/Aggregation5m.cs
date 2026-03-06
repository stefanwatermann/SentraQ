using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("vAggregation5m")]
public class Aggregation5m
{
    [MaxLength(36)]
    public required string HardwareId { get; init; }
    
    [Column("date_bin")]
    public DateTime DateBin { get; set; }
    
    [Column("sum")]
    public double Sum { get; set; }
}