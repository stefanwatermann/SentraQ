using System.Collections.Generic;
using System.Linq;
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
using Data = SentraqModels.Data;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/components")]
public class ComponentController(
    DatabaseContext dbContext,
    ComponentService componentService,
    ILogger<ComponentController> logger) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("last")]
    public IEnumerable<Api.Component> GetComponentsLast()
    {
        var components = dbContext
            .ComponentsView
            .Include(c => c.Station)
            .OrderBy(c => c.DisplayOrder)
            .Select(c => ComponentMapper.Map(c));
        
        return components;
    }
    
    [RequireAuthorizationKey]
    [HttpGet("station/{stationUid}")]
    public IEnumerable<Api.Component> GetByStation(string stationUid)
    {
        var components = dbContext
            .Components
            .Include(c => c.Station)
            .Where(c => c.Station.Uid == stationUid)
            .OrderBy(c => c.DisplayOrder)
            .Select(c => ComponentMapper.Map(c));
        
        return components;
    }

    [RequireAuthorizationKey]
    [HttpGet("{componentUid}")]
    public Api.Component Get(string componentUid)
    {
        var componentView = dbContext
                                .ComponentsView
                                .Include(c => c.Station)
                                .FirstOrDefault(c => c.HardwareId == componentUid.Sanitize(36)) ??
                            throw new KeyNotFoundException("Component not found");

        return ComponentMapper.Map(componentView);
    }
    
    /// <summary>
    /// Update existing Component
    /// </summary>
    /// <param name="component"></param>
    /// <param name="changedBy"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [RequireAuthorizationKey]
    [NotAllowedExceptionFilter]
    [HttpPost()]
    public void Write([FromBody] Api.Component component, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        var station = dbContext.Stations.SingleOrDefault(s => s.Uid == component.StationUid) ??
                      throw new KeyNotFoundException($"Station {component.StationUid} of given Component not found.");
        
        componentService.WriteComponent(ComponentMapper.Map(component, station.Id), changedBy.Sanitize(10));
    }

    /// <summary>
    /// Delete Component.
    /// </summary>
    /// <param name="hardwareId"></param>
    /// <param name="changedBy"></param>
    [RequireAuthorizationKey]
    [NotAllowedExceptionFilter]
    [HttpDelete("{hardwareId}")]
    public void Remove(string hardwareId, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        componentService.Removecomponent(hardwareId.Sanitize(36), changedBy.Sanitize(10));
    }
}