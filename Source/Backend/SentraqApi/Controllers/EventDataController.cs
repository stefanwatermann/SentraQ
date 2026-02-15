using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/eventData")]
public class EventDataController(
    DatabaseContext dbContext) : ControllerBase
{
    [AuthorizationKey]
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
    
    [AuthorizationKey]
    [HttpGet("{hid}")]
    public IQueryable<Api.EventData> GetLast100(string hid)
    {
        var filter = $"%{hid}%";
        var eventData = dbContext
            .EventData
            .FromSql($"SELECT * FROM public.\"EventData\" WHERE \"HardwareId\" like {filter}")
            .AsNoTracking()
            .OrderByDescending(e => e.ReceivedTs)
            .Take(100)
            .Select(e => EventDataMapper.Map(e));
        
        return eventData;
    }
}