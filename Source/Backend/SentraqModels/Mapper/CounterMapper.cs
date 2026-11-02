// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Enums;

namespace SentraqModels.Mapper;

public static class CounterMapper
{
    /// <summary>
    /// Specialized mapper used to integrate Counters into lists of Components.
    /// Similar to database-view vComponentLast but without performance issues due to EventData access.
    /// </summary>
    /// <param name="counter"></param>
    /// <param name="stationUid"></param>
    /// <returns></returns>
    public static Api.Component Map(Data.Counter counter, string stationUid)
    {
        return new Api.Component()
        {
            StationUid = stationUid,
            HardwareId = $"{counter.HardwareId}#",
            Type = counter.Type == Enums.CounterType.timediff ? "CO" : "CV",
            DisplayName = counter.DisplayName,
            ShortName = counter.ShortName,
            MaxValue = 0,
            MinValue = 999999999,
            DisplayUnit = counter.DisplayUnit,
            DisplayOrder = counter.DisplayOrder,
            Removed = counter.Removed,
            Visible = counter.Visible,
            AdjustmentFunction = counter.AdjustmentFunction,
            ForwardToHardwareId = null
        };
    }
    
    public static Data.Counter Map(Api.Component component)
    {
        return new Data.Counter()
        {
            HardwareId = component.HardwareId.Replace("#", ""),
            Type = component.Type.FromString() == ComponentType.CounterTimeDiff ? CounterType.timediff : CounterType.valueadd,
            DisplayName = component.DisplayName,
            ShortName = component.ShortName,
            DisplayUnit = component.DisplayUnit,
            DisplayOrder = component.DisplayOrder,
            Removed = component.Removed,
            Visible = component.Visible,
            AdjustmentFunction = component.AdjustmentFunction
        };
    }
}