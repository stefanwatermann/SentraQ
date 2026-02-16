using System.Text.Json;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;
using Data = SentraqModels.Data;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/stations")]
public class StationController(
    ILogger<StationController> logger,
    StationService stationService,
    DatabaseContext dbContext) : ControllerBase
{
    /// <summary>
    /// Returns a list of all stations.
    /// </summary>
    /// <returns>List of stations</returns>
    [RequireAuthorizationKey]
    [HttpGet("")]
    public IEnumerable<Api.Station?> Get()
    {
        logger.LogInformation("Get all stations");

        var dataStations = dbContext
            .StationsView
            .OrderBy(s => s.DisplayOrder);

        return dataStations
            .Select(dataStation => StationMapper.Map(dataStation))
            .ToList();
    }
    
    [RequireAuthorizationKey]
    [HttpGet("{stationUid}")]
    public Api.Station? GetStation(string stationUid)
    {
        logger.LogInformation("Get station {stationUid}", stationUid.Sanitize(36));

        var dataStation = dbContext
            .StationsView
            .FirstOrDefault(s => s.Uid == stationUid.Sanitize(36));
        
        return StationMapper.Map(dataStation);
    }

    /// <summary>
    /// Returns all components of the specified station.
    /// </summary>
    /// <param name="stationUid">Uid of station</param>
    /// <returns>List of components</returns>
    [RequireAuthorizationKey]
    [HttpGet("{stationUid}/components/")]
    public IEnumerable<Api.Component> GetComponents(string stationUid)
    {
        logger.LogInformation($"Getting components for station {stationUid}");

        var components = dbContext
            .ComponentsView
            .Where(c => c.StationUid == stationUid)
            .OrderBy(c => c.DisplayOrder);

        var r = components
            .Select(componentView => ComponentMapper.Map(componentView))
            .ToList();

        return r;
    }

    /// <summary>
    /// Update existing Station
    /// </summary>
    /// <param name="station"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [RequireAuthorizationKey]
    [HttpPut()]
    public void Update([FromBody] Api.Station station)
    {
        var ds = dbContext
                     .Stations
                     .FirstOrDefault(s => s.Uid == station.Uid) 
                 ?? throw new KeyNotFoundException("Station not found");

        ds.DisplayName = station.DisplayName;
        ds.ShortName = station.ShortName;
        ds.Type = station.Type;
        ds.Longitude = station.Location.Longitude;
        ds.Latitude = station.Location.Latitude;
        ds.DisplayOrder = station.DisplayOrder;

        dbContext.Set<Data.Station>().Update(ds);
        dbContext.SaveChanges();
    }

    /// <summary>
    /// Add new Station, Guid will be generated. Any provided Guid will be ignored.
    /// </summary>
    /// <param name="station"></param>
    /// <returns></returns>
    [RequireAuthorizationKey]
    [HttpPost()]
    public string Add([FromBody] Api.Station station)
    {
        var ds = new Data.Station()
        {
            Uid = Guid.NewGuid().ToString(),
            DisplayName = station.DisplayName,
            ShortName = station.ShortName,
            Type = station.Type,
            Longitude = station.Location.Longitude,
            Latitude = station.Location.Latitude,
            DisplayOrder = station.DisplayOrder
        };

        dbContext.Set<Data.Station>().Add(ds);
        dbContext.SaveChanges();

        return ds.Uid;
    }

    /// <summary>
    /// Delete Station.
    /// </summary>
    /// <param name="guid"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [RequireAuthorizationKey]
    [HttpDelete("{uid}")]
    public void Add(string uid)
    {
        var ds = dbContext
                     .Stations
                     .FirstOrDefault(s => s.Uid == uid)
                 ?? throw new KeyNotFoundException("Station not found");

        dbContext.Set<Data.Station>().Remove(ds);
        dbContext.SaveChanges();
    }
    
    [RequireAuthorizationKey]
    [HttpPost("{uid}/clearAlert")]
    public void ClearAlert(string uid)
    {
        var json = Request.ReadFromJsonAsync<JsonElement>().Result;
        var user= json.GetString("user") ?? "unbekannt";
        stationService.ClearAlert(uid, user);
    }
}