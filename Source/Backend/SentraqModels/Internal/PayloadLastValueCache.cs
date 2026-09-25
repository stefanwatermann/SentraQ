namespace SentraqModels.Internal;

public class PayloadLastValueCache
{
    public required string HardwareId { get; init; }
    public required string LastPayload { get; set; } = string.Empty;
    public required DateTime LastChangedTs { get; set; }
}