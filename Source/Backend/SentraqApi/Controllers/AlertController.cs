using System.Text.Json.Nodes;
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
    [HttpPost("")]
    public IQueryable<Api.Alert> Get([FromBody] JsonObject filter, [FromQuery] DateTime from, DateTime to)
    {
        var uids = filter.FirstOrDefault(j => j.Key == "uid").Value;
        var stationUids = uids == null ? Array.Empty<string>() : uids.ToString().Sanitize(5000).Split(',');
        
        var alerts = dbContext
            .Alerts
            .Where(a => a.FirstEventTs >= from && a.FirstEventTs <= to && stationUids.Contains(a.StationUid))
            .AsNoTracking()
            .OrderByDescending(e => e.Id)
            .Select(e => AlertMapper.Map(e));
        
        return alerts;
    }
    
    [RequireAuthorizationKey]
    [HttpGet("{stationUid}")]
    public IQueryable<Api.Alert> GetLast(string stationUid, [FromQuery] int take = 100)
    {
        var alerts = dbContext
            .Alerts
            .Where(a => a.StationUid == stationUid.Sanitize(36))
            .AsNoTracking()
            .OrderByDescending(e => e.Id)
            .Take(take)
            .Select(e => AlertMapper.Map(e));
        
        return alerts;
    }
}