namespace SentraqModels.Api;

public class EventDataExport
{
    public required string StationName { get; init; }
    public required string StationUid { get; init; }
    public required string ComponentName { get; init; }
    public required string HardwareId { get; init; }
    public required string ComponentType { get; init; }
    public required DateTime Received { get; init; }
    public string? Unit { get; init; }
    public double Value { get; init; }
}