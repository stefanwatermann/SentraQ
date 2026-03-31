using SentraqModels.Extensions;

namespace SentraqModels.Mapper;

public static class ComponentMapper
{
    public static Api.Component Map(Data.ComponentView componentView)
    {
        return new Api.Component()
        {
            StationUid = componentView.Station.Uid ?? "unknown",
            HardwareId = componentView.HardwareId,
            Type = componentView.Type,
            DisplayName = componentView.DisplayName,
            ShortName = componentView.ShortName,
            CurrentValue = componentView.AdjustedPayload(),
            LastReceivedTs = componentView.LastReceivedTs,
            FirstReceivedTs = componentView.FirstReceivedTs,
            MaxValue = componentView.MaxValue,
            MinValue = componentView.MinValue,
            DisplayUnit = componentView.DisplayUnit,
            DisplayOrder = componentView.DisplayOrder
        };
    }
    
    public static Api.Component Map(Data.Component componentView)
    {
        return new Api.Component()
        {
            StationUid = componentView.Station?.Uid ?? "unknown",
            HardwareId = componentView.HardwareId,
            Type = componentView.Type,
            DisplayName = componentView.DisplayName,
            ShortName = componentView.ShortName,
            MaxValue = componentView.MaxValue,
            MinValue = componentView.MinValue,
            DisplayUnit = componentView.DisplayUnit,
            DisplayOrder = componentView.DisplayOrder
        };
    }
    
    public static Data.Component Map(Api.Component component, long stationId)
    {
        return new Data.Component()
        {
            StationId = stationId,
            HardwareId = component.HardwareId,
            Type = component.Type,
            DisplayName = component.DisplayName,
            ShortName = component.ShortName,
            MaxValue = component.MaxValue,
            MinValue = component.MinValue,
            DisplayUnit = component.DisplayUnit,
            DisplayOrder = component.DisplayOrder
        };
    }
}