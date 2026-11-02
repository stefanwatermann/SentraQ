// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
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