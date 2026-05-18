namespace SentraqModels.Api;

public class Alert
{
    public required string StationUid { get; init; } = string.Empty;
    
    public DateTime? ConfirmedAt { get; set; }
    
    public string? ConfirmedBy { get; set; }
    
    public DateTime? MailSendAt { get; set; }
    
    public DateTime? FirstEventTs { get; set; }
    
    public DateTime? LastEventTs { get; set; }
    
    public bool IsActive { get; set; } 
    
    public string? Faults { get; set; }
}