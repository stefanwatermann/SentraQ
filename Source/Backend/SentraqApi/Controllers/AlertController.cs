using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/alert")]
public class AlertController(
    DatabaseContext dbContext) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("")]
    public IQueryable<Api.Alert> GetLast100()
    {
        var alerts = dbContext
            .Alerts
            .AsNoTracking()
            .OrderByDescending(e => e.Id)
            .Take(100)
            .Select(e => AlertMapper.Map(e));
        
        return alerts;
    }
    
    [RequireAuthorizationKey]
    [HttpGet("{stationUid}")]
    public IQueryable<Api.Alert> GetLast100(string stationUid)
    {
        var filter = $"%{stationUid.Sanitize(36)}%";
        
        var alerts = dbContext
            .Alerts
            .FromSql($"SELECT * FROM public.\"Alert\" WHERE \"StationUid\" like {filter}")
            .AsNoTracking()
            .OrderByDescending(e => e.Id)
            .Take(100)
            .Select(e => AlertMapper.Map(e));
        
        return alerts;
    }
}