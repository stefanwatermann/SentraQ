using System.Text.Json.Nodes;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

/// <summary>
/// Provides information from the EventData table.
/// </summary>
/// <param name="logger"></param>
/// <param name="logService"></param>
/// <param name="dbContext"></param>
[ApiController]
[Route("api/eventData")]
public class EventDataController(
    ILogger<EventDataController> logger,
    LogService logService,
    DatabaseContext dbContext) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("")]
    public IQueryable<Api.EventData> GetLast100()
    {
        var eventData = dbContext
            .EventData
            .AsNoTracking()
            .OrderByDescending(e => e.ReceivedTs)
            .Take(100)
            .Select(e => EventDataMapper.Map(e));
        
        return eventData;
    }
    
    [RequireAuthorizationKey]
    [HttpGet("{hid}")]
    public IQueryable<Api.EventData> GetLast100(string hid)
    {
        var filter = $"%{hid.Sanitize(36)}%";
        var eventData = dbContext
            .EventData
            .FromSql($"SELECT * FROM public.\"EventData\" WHERE \"HardwareId\" like {filter}")
            .AsNoTracking()
            .OrderByDescending(e => e.ReceivedTs)
            .Take(100)
            .Select(e => EventDataMapper.Map(e));
        
        return eventData;
    }
    
    [RequireAuthorizationKey]
    [HttpPost("export")]
    public IQueryable<Api.EventDataExport> Export([FromBody] JsonObject filter, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        var uids = filter.FirstOrDefault(j => j.Key == "uid").Value;
        var types = filter.FirstOrDefault(j => j.Key == "type").Value;
        var from = filter.FirstOrDefault(j => j.Key == "from").Value;
        var to = filter.FirstOrDefault(j => j.Key == "to").Value;
        
        var stationUids = uids == null ? Array.Empty<string>() : uids.ToString().Sanitize(5000).Split(',');
        var componentTypes = types == null ? Array.Empty<string>() : types.ToString().Sanitize(5000).Split(',');
        var receivedFrom = from?.GetValue<DateTime>() ?? DateTime.MinValue;
        var receivedTo = to?.GetValue<DateTime>() ?? DateTime.MaxValue;

        var exportInfo = $"stations={string.Join(',', stationUids)}, components={string.Join(',', componentTypes)}, receivedFrom={receivedFrom}, receivedTo={receivedTo}";
        
        logger.LogInformation("Export started: {exportInfo}", exportInfo);
        
        var eventData = dbContext
            .EventDataExports
            .AsNoTracking()
            .Where(e => 
                stationUids.Contains(e.StationUid) &&
                componentTypes.Contains(e.ComponentType) &&
                e.Received >= receivedFrom &&
                e.Received <= receivedTo)
            .Distinct()
            .OrderByDescending(e => e.StationName)
            .ThenBy(e => e.HardwareId)
            .ThenByDescending(e => e.Received)
            .Select(e => EventDataMapper.Map(e));
        
        logService.SaveInfo(LogService.Event.DataExportRequested, $"{changedBy.Sanitize(10)} exported {eventData.Count()} rows for {exportInfo}");
        
        return eventData;
    }
}