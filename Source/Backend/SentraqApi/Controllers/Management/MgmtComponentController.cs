using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqApi.Filters;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers.Management;

[ApiController]
[RequireAuthorizationKey]
[Route("api/management/component")]
public class MgmtComponentController(
    ILogger<MgmtComponentController> logger,
    StationService stationService,
    ComponentService componentService) : ControllerBase
{
    /// <summary>
    /// Add new or update existing Component
    /// </summary>
    /// <param name="component"></param>
    /// <param name="changedBy"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [NotAllowedExceptionFilter]
    [HttpPost()]
    public void Write([FromBody] Api.Component component, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        var station = stationService.GetStations().SingleOrDefault(s => s.Uid == component.StationUid) ??
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
        componentService.RemoveComponent(hardwareId.Sanitize(36), changedBy.Sanitize(10));
    }
}