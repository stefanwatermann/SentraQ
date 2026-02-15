using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("Log")]
public class Log
{
    [Key]
    public long Id { get; init; }
    
    public required DateTime LogTs { get; set; }
    
    [MaxLength(60)]
    public required string Event { get; set; } = string.Empty;
    
    [DefaultValue("I")]
    [MaxLength(1)]
    [AllowedValues("I", "E", "W")]
    public string Severity { get; set; } = string.Empty;
    
    [MaxLength(1000)]
    public string? Message { get; set; } = string.Empty;
}