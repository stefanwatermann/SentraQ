using SentraqModels.Extensions;

namespace SentraqModels.Mapper;

public static class AggregationMapper
{
    public static Api.Aggregation Map(Data.Aggregation1d aggregation)
    {
        return new Api.Aggregation()
        {
            HardwareId = aggregation.HardwareId,
            DateBin = aggregation.DateBin,
            Sum = aggregation.Sum
        };
    }
    
    public static Api.Aggregation Map(Data.Aggregation1h aggregation)
    {
        return new Api.Aggregation()
        {
            HardwareId = aggregation.HardwareId,
            DateBin = aggregation.DateBin,
            Sum = aggregation.Sum
        };
    }
    
    public static Api.Aggregation Map(Data.Aggregation5m aggregation)
    {
        return new Api.Aggregation()
        {
            HardwareId = aggregation.HardwareId,
            DateBin = aggregation.DateBin,
            Sum = aggregation.Sum
        };
    }
}