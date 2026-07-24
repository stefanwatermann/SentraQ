namespace SentraqModels.Mapper;

public static class AggregationMapper
{
    public static Api.Aggregation Map(Data.Aggregation aggregation)
    {
        return new Api.Aggregation()
        {
            HardwareId = aggregation.HardwareId,
            DateBin = aggregation.DateBin,
            Sum = aggregation.Value
        };
    }
}