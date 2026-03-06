namespace SentraqModels.Api;

public class Aggregation
{
    public required string HardwareId { get; init; }
    
    public DateTime DateBin { get; set; }
    
    public double Sum { get; set; }
}