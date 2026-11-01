using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqApi.Filters;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Enums;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers.Management;

/// <summary>
/// Manages Components and Counters.
/// </summary>
/// <param name="logger"></param>
/// <param name="dbContext"></param>
/// <param name="stationService"></param>
/// <param name="componentService"></param>
/// <param name="counterService"></param>
[ApiController]
[RequireAuthorizationKey]
[Route("api/management/component")]
public class MgmtComponentController(
    ILogger<MgmtComponentController> logger,
    DatabaseContext dbContext,
    StationService stationService,
    ComponentService componentService,
    CounterService counterService) : ControllerBase
{
    /// <summary>
    /// Returns a list of all components of a Station, including counters mapped as components.
    /// </summary>
    /// <returns>List of all components</returns>
    [HttpGet("byStation/{stationUid}")]
    public IEnumerable<Api.Component?> GetComponentsByStation(string stationUid)
    {
        logger.LogInformation("Get all components of Station {uid}", stationUid.Sanitize(36));
        
        // get all components of the station
        var components = dbContext
            .Components
            .Include(s => s.Station)
            .Where(c => c.Station.Uid == stationUid.Sanitize(36))
            .AsEnumerable()
            .Select(ComponentMapper.Map)
            .ToList();

        // get associated counters and convert them to components
        var counters = dbContext
            .Counters
            .Where(co => components.Select(cn => cn.HardwareId).Contains(co.HardwareId))
            .Select(co => CounterMapper.Map(co, stationUid))
            .ToList();
        
        return components
            .Union(counters)
            .OrderBy(c => c.DisplayOrder);
    }
    
    /// <summary>
    /// Add new or update existing Component/Counter
    /// </summary>
    /// <param name="component"></param>
    /// <param name="changedBy"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [NotAllowedExceptionFilter]
    [HttpPost()]
    public void Write([FromBody] Api.Component component, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        var cb = changedBy.Sanitize(10);
        
        var station = stationService.GetStations().SingleOrDefault(s => s.Uid == component.StationUid) ??
                      throw new KeyNotFoundException($"Station {component.StationUid} of given Component not found.");
        
        if (component.Type.FromString() == ComponentType.CounterTimeDiff || 
            component.Type.FromString() == ComponentType.CounterValueAdd)
            counterService.WriteCounter(CounterMapper.Map(component), cb);
        else
            componentService.WriteComponent(ComponentMapper.Map(component, station.Id), cb);
    }

    /// <summary>
    /// Delete Component/Counter.
    /// </summary>
    /// <param name="hardwareId"></param>
    /// <param name="changedBy"></param>
    [RequireAuthorizationKey]
    [NotAllowedExceptionFilter]
    [HttpDelete("{hardwareId}")]
    public void Remove(string hardwareId, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        var hid = hardwareId.Sanitize(36);
        var cb = changedBy.Sanitize(10);
        
        var component = dbContext.Components.FirstOrDefault(c => c.HardwareId == hid) ??
                        throw new KeyNotFoundException($"Component/Counter {hid} not found.");
        
        if (component.Type.FromString() == ComponentType.CounterTimeDiff || 
            component.Type.FromString() == ComponentType.CounterValueAdd)
            counterService.RemoveCounter(hid, cb);
        else
            componentService.RemoveComponent(hid, cb);
    }
}