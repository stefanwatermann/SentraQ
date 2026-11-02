using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqApi.Filters;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers.Management;

/// <summary>
/// API used by the Sentraq management tool (Desktop App).
/// </summary>
/// <param name="logger"></param>
/// <param name="stationService"></param>
[ApiController]
[RequireAuthorizationKey]
[Route("api/management/station")]
public class MgmtStationController(
    ILogger<MgmtStationController> logger,
    StationService stationService) : ControllerBase
{
    /// <summary>
    /// Returns a list of all stations from Station table.
    /// </summary>
    /// <returns>List of all stations</returns>
    [HttpGet]
    public IEnumerable<Api.Station?> GetStations()
    {
        logger.LogInformation("Get all stations from Station table");
        return stationService.GetStations()
            .Select(StationMapper.Map)
            .ToList();
    }

    /// <summary>
    /// Add new or update existing Station
    /// </summary>
    /// <param name="station"></param>
    /// <param name="changedBy"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    [NotAllowedExceptionFilter]
    [HttpPost]
    public void WriteStation([FromBody] Api.Station station, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        stationService.WriteStation(StationMapper.Map(station), changedBy.Sanitize(10));
    }

    /// <summary>
    /// Delete Station.
    /// </summary>
    /// <param name="uid"></param>
    /// <param name="changedBy"></param>
    [NotAllowedExceptionFilter]
    [HttpDelete("{uid}")]
    public void RemoveStation(string uid, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        stationService.RemoveStation(uid.Sanitize(36), changedBy.Sanitize(10));
    }
}