using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/aggregation")]
public class AggregationController(
    AggregationService aggregationService) : ControllerBase
{
    /// <summary>
    /// Returns by date-time aggregated values from one of the vAggregation... views.
    /// </summary>
    /// <param name="postfix">Postfix of an aggregation-view name (e.g. Avg5m), case-sensitive!</param>
    /// <param name="hwId">HardwareId of the component to aggregate over</param>
    /// <param name="take">Number of records to return</param>
    /// <returns></returns>
    [RequireAuthorizationKey]
    [HttpGet("{postfix}/{hwId}")]
    public IEnumerable<Api.Aggregation> GetAggregation(string postfix, string hwId, [FromQuery] int take = 100)
    {
        var agg = aggregationService
            .Get(postfix.Sanitize(5), hwId.Sanitize(36), take);
        
        return agg.Select(AggregationMapper.Map);
    }
}