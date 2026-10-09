using System.Diagnostics.CodeAnalysis;
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
[RequireAuthorizationKey]
[Route("api/components")]
public class ComponentController(
    DatabaseContext dbContext,
    ComponentService componentService,
    ILogger<ComponentController> logger) : ControllerBase
{
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
    
    [HttpGet("station/{stationUid}")]
    public IEnumerable<Api.Component> GetByStation(string stationUid)
    {
        var components = dbContext
            .Components
            .Include(c => c.Station)
            .Where(c => c.Station.Uid == stationUid && c.Removed == false)
            .OrderBy(c => c.DisplayOrder)
            .Select(c => ComponentMapper.Map(c))
            .ToList();
        
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
    /// Set value of a component. Triggers an MQTT message to the component.
    /// </summary>
    /// <param name="hardwareId"></param>
    /// <param name="value"></param>
    /// <param name="changedBy"></param>
    [HttpPost("setValue/{hardwareId}")]
    [Experimental("MqttMessageSender")]
    public void SetValue(string hardwareId, [FromBody] string? value, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        componentService.SendValue(hardwareId, value, changedBy);
    }
}