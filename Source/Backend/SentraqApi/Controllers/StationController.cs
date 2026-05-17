using System.Text.Json;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqApi.Filters;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/station")]
public class StationController(
    ILogger<StationController> logger,
    StationService stationService,
    DatabaseContext dbContext) : ControllerBase
{
    /// <summary>
    /// Returns a list of all stations from StationView (vStation).
    /// </summary>
    /// <returns>List of stations</returns>
    [RequireAuthorizationKey]
    [HttpGet("")]
    public IEnumerable<Api.Station?> Get()
    {
        logger.LogInformation("Get all stations");

        return stationService.GetStationsView()
            .Select(StationMapper.Map)
            .ToList();
    }
    
    /// <summary>
    /// Returns the station object of the given Uid, from StationView (vStation).
    /// </summary>
    /// <param name="stationUid"></param>
    /// <returns></returns>
    [RequireAuthorizationKey]
    [HttpGet("{stationUid}")]
    public Api.Station? GetStation(string stationUid)
    {
        var uid = stationUid.Sanitize(36);
        
        logger.LogInformation("Get station {stationUid}", uid);
        
        return StationMapper.Map(stationService.GetStationView(uid));
    }

    /// <summary>
    /// Returns all components of the specified station, from ComponentsView (vComponentList).
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
    
    /// <summary>
    /// Clear active alert of the given station.
    /// </summary>
    /// <param name="uid"></param>
    [RequireAuthorizationKey]
    [HttpPost("{uid}/clearAlert")]
    public void ClearAlert(string uid)
    {
        var json = Request.ReadFromJsonAsync<JsonElement>().Result;
        var user= json.GetString("user") ?? "unbekannt";
        stationService.ClearAlert(uid, user);
    }
    
    [RequireAuthorizationKey]
    [HttpPost("{uid}/startMaintenance")]
    public void StartMaintenanceMode(string uid, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        stationService.SetMaintenanceMode(uid, DateTime.Now, changedBy);
    }
    
    [RequireAuthorizationKey]
    [HttpPost("{uid}/endMaintenance")]
    public void EndMaintenanceMode(string uid, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        stationService.SetMaintenanceMode(uid, null, changedBy);
    }
}