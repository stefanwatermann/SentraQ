using SentraqModels.Extensions;

namespace SentraqModels.Mapper;

public static class ComponentMapper
{
    public static Api.Component Map(Data.ComponentView componentView)
    {
        return new Api.Component()
        {
            StationUid = componentView.StationUid ?? "unknown",
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
}