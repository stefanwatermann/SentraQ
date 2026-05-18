using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/eventData")]
public class EventDataController(
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
    [HttpGet("export")]
    public IQueryable<Api.EventDataExport> Export(
        [FromQuery] string? uid, 
        [FromQuery] string? type, 
        [FromQuery] DateTime? from, 
        [FromQuery] DateTime? to)
    {
        var stationUids = uid == null ? new string[0] : uid.Sanitize(1000).Split(',');
        var componentTypes = type == null ? new string[0] : type.Sanitize(1000).Split(',');
        var receivedFrom = from ?? DateTime.MinValue;
        var receivedTo = to ?? DateTime.MaxValue;
        
        var eventData = dbContext
            .EventDataExports
            .Where(e => 
                (stationUids.Length == 0 || stationUids.Contains(e.StationUid)) &&
                (componentTypes.Length == 0 || componentTypes.Contains(e.ComponentType)) &&
                e.Received >= receivedFrom &&
                e.Received <= receivedTo)
            .OrderByDescending(e => e.Received)
            .Select(e => EventDataMapper.Map(e));
        
        return eventData;
    }
}