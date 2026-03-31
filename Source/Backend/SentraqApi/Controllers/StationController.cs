using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SentraqApi.Attributes;
using SentraqApi.Filters;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

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
        logger.LogInformation($"Getting components for station {stationUid.Sanitize(36)}");

        var components = dbContext
            .ComponentsView
            .Include(c => c.Station)
            .Where(c => c.Station.Uid == stationUid.Sanitize(36))
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
    /// <param name="changedBy"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [RequireAuthorizationKey]
    [NotAllowedExceptionFilter]
    [HttpPost()]
    public void Write([FromBody] Api.Station station, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        stationService.WriteStation(StationMapper.Map(station), changedBy.Sanitize(10));
    }

    /// <summary>
    /// Delete Station.
    /// </summary>
    /// <param name="uid"></param>
    /// <param name="changedBy"></param>
    [RequireAuthorizationKey]
    [NotAllowedExceptionFilter]
    [HttpDelete("{uid}")]
    public void Remove(string uid, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        stationService.RemoveStation(uid.Sanitize(36), changedBy.Sanitize(10));
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