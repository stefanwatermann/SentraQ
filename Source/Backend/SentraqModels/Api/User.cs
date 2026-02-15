namespace SentraqModels.Api;

public class User
{
    public required string Login { get; set; } = string.Empty;
    
    public required string Name { get; set; } = string.Empty;
    
    public required string Hash { get; set; } = string.Empty;

    public string? Email { get; set; }

    public required string Role { get; set; } = string.Empty;
}