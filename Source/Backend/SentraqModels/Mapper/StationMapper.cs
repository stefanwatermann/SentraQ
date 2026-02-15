namespace SentraqModels.Mapper;

public static class StationMapper
{
    public static Api.Station? Map(Data.StationView? dataStation)
    {
        if (dataStation == null)
            return null;
        
        return new Api.Station()
        {
            Uid = dataStation.Uid,
            Location = new Api.GeoLocation() { Latitude = dataStation.Latitude, Longitude = dataStation.Longitude },
            Type = dataStation.Type,
            DisplayName = dataStation.DisplayName,
            ShortName = dataStation.ShortName,
            DisplayColor = dataStation.DisplayColor,
            DisplayOrder = dataStation.DisplayOrder,
            HasActiveAlert = dataStation.HasActiveAlert
        };
    }
}