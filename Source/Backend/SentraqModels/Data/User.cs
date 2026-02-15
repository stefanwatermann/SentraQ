using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("User")]
public class User
{
    [Key]
    public long Id { get; init; }
    
    [MaxLength(10)]
    public required string Login { get; set; } = string.Empty;
    
    [MaxLength(200)]
    public required string Name { get; set; } = string.Empty;
    
    [MaxLength(100)]
    public required string Email { get; set; } = string.Empty;
    
    [MaxLength(1000)]
    public required string Hash { get; set; } = string.Empty;
    
    [DefaultValue("USR")]
    [AllowedValues("USR", "ADM", "RPT")]
    [MaxLength(3)]
    public required string Role { get; set; } = string.Empty;
    
    [MaxLength(100)]
    public string? PasswordResetCode { get; set; }
    
    public DateTime? PasswordResetTs { get; set; }
}