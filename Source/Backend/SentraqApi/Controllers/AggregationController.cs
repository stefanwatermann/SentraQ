using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/aggregation")]
public class AggregationController(
    DatabaseContext dbContext,
    ILogger<ComponentController> logger) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("5m/{componentUid}")]
    public IQueryable<Api.Aggregation> Get5m(string componentUid, [FromQuery] int take = 100)
    {
        return dbContext
            .Aggregation5ms
            .Where(a => a.HardwareId == componentUid.Sanitize(36))
            .OrderByDescending(a => a.DateBin)
            .Take(take)
            .Select(a => AggregationMapper.Map(a));
    }
    
    [RequireAuthorizationKey]
    [HttpGet("1h/{componentUid}")]
    public IQueryable<Api.Aggregation> Get1h(string componentUid, [FromQuery] int take = 100)
    {
        return dbContext
            .Aggregation1hs
            .Where(a => a.HardwareId == componentUid.Sanitize(36))
            .OrderByDescending(a => a.DateBin)
            .Take(take)
            .Select(a => AggregationMapper.Map(a));
    }
    
    [RequireAuthorizationKey]
    [HttpGet("1d/{componentUid}")]
    public IQueryable<Api.Aggregation> Get1d(string componentUid, [FromQuery] int take = 100)
    {
        return dbContext
            .Aggregation1ds
            .Where(a => a.HardwareId == componentUid.Sanitize(36))
            .OrderByDescending(a => a.DateBin)
            .Take(take)
            .Select(a => AggregationMapper.Map(a));
    }
}