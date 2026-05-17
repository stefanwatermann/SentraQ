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
            Latitude = dataStation.Latitude, 
            Longitude = dataStation.Longitude,
            Type = dataStation.Type,
            DisplayName = dataStation.DisplayName,
            ShortName = dataStation.ShortName,
            DisplayColor = dataStation.DisplayColor,
            DisplayOrder = dataStation.DisplayOrder,
            WatchdogHardwareId = dataStation.WatchdogHardwareId,
            HasActiveAlert = dataStation.HasActiveAlert,
            MaintenanceActiveSinceTs = dataStation.MaintenanceActiveSinceTs
        };
    }
    
    public static Data.Station Map(Api.Station apiStation)
    {
        return new Data.Station()
        {
            Uid = apiStation.Uid,
            Latitude = apiStation.Latitude, 
            Longitude = apiStation.Longitude,
            Type = apiStation.Type,
            DisplayName = apiStation.DisplayName,
            ShortName = apiStation.ShortName,
            DisplayColor = apiStation.DisplayColor,
            DisplayOrder = apiStation.DisplayOrder,
            WatchdogHardwareId = apiStation.WatchdogHardwareId,
            MaintenanceActiveSinceTs = apiStation.MaintenanceActiveSinceTs
        };
    }
    
    public static void Map(Api.Station fromApiStation, Data.Station toDataStation)
    {
        if (toDataStation.Uid != fromApiStation.Uid)
            throw new ArgumentException("Station Uid does not match.");

        toDataStation.Latitude = fromApiStation.Latitude;
        toDataStation.Longitude = fromApiStation.Longitude;
        toDataStation.Type = fromApiStation.Type;
        toDataStation.DisplayName = fromApiStation.DisplayName;
        toDataStation.ShortName = fromApiStation.ShortName;
        toDataStation.DisplayColor = fromApiStation.DisplayColor;
        toDataStation.DisplayOrder = fromApiStation.DisplayOrder;
        toDataStation.WatchdogHardwareId = fromApiStation.WatchdogHardwareId;
        toDataStation.MaintenanceActiveSinceTs = fromApiStation.MaintenanceActiveSinceTs;
    }
}