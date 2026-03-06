using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqCommon.Context;
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
    public IQueryable<Api.Aggregation> Get5m(string componentUid)
    {
        return dbContext
            .Aggregation5ms
            .Where(a => a.HardwareId == componentUid)
            .Select(a => AggregationMapper.Map(a));
    }
    
    [RequireAuthorizationKey]
    [HttpGet("1h/{componentUid}")]
    public IQueryable<Api.Aggregation> Get1h(string componentUid)
    {
        return dbContext
            .Aggregation1hs
            .Where(a => a.HardwareId == componentUid)
            .Select(a => AggregationMapper.Map(a));
    }
    
    [RequireAuthorizationKey]
    [HttpGet("1d/{componentUid}")]
    public IQueryable<Api.Aggregation> Get1d(string componentUid)
    {
        return dbContext
            .Aggregation1ds
            .Where(a => a.HardwareId == componentUid)
            .Select(a => AggregationMapper.Map(a));
    }
}