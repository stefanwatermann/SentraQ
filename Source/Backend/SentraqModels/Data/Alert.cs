using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("Alert")]
public class Alert
{
    [Key]
    public long Id { get; init; }
    
    [MaxLength(36)]
    public required string StationUid { get; init; } = string.Empty;
    
    public DateTime? ConfirmedAt { get; set; }
    
    [MaxLength(100)]
    public string? ConfirmedBy { get; set; }
    
    public DateTime? MailSendAt { get; set; }
    
    public DateTime? FirstEventTs { get; set; }
    
    public DateTime? LastEventTs { get; set; }
    
    [DefaultValue("A")]
    [MaxLength(1)]
    [AllowedValues("Y", "N")]
    public string IsActive { get; set; } = string.Empty;
}