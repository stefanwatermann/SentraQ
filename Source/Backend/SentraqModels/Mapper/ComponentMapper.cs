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
            DisplayOrder = componentView.DisplayOrder,
            AdjustmentFunction = componentView.AdjustmentFunction
        };
    }
    
    public static Api.Component Map(Data.Component component)
    {
        return new Api.Component()
        {
            StationUid = component.Station?.Uid ?? "unknown",
            HardwareId = component.HardwareId,
            Type = component.Type,
            DisplayName = component.DisplayName,
            ShortName = component.ShortName,
            MaxValue = component.MaxValue,
            MinValue = component.MinValue,
            DisplayUnit = component.DisplayUnit,
            DisplayOrder = component.DisplayOrder,
            Removed = component.Removed,
            Visible = component.Visible,
            AdjustmentFunction = component.AdjustmentFunction,
            ForwardToHardwareId = component.ForwardToHardwareId
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
            DisplayOrder = component.DisplayOrder,
            Removed = component.Removed,
            Visible = component.Visible,
            AdjustmentFunction = component.AdjustmentFunction,
            ForwardToHardwareId = component.ForwardToHardwareId
        };
    }
}