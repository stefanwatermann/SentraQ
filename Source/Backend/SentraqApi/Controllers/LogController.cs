using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/log")]
public class LogController(
    DatabaseContext dbContext) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("")]
    public IQueryable<Api.Log> GetLast100()
    {
        var logs = dbContext
            .Logs
            .AsNoTracking()
            .OrderByDescending(e => e.Id)
            .Take(100)
            .Select(e => LogMapper.Map(e));
        
        return logs;
    }
    
    [RequireAuthorizationKey]
    [HttpGet("{evnt}")]
    public IQueryable<Api.Log> GetLast100(string evnt)
    {
        var filter = $"%{evnt.Sanitize(60)}%";
        
        var logs = dbContext
            .Logs
            .FromSql($"SELECT * FROM public.\"Log\" WHERE \"Event\" like {filter}")
            .AsNoTracking()
            .OrderByDescending(e => e.Id)
            .Take(100)
            .Select(e => LogMapper.Map(e));
        
        return logs;
    }
}