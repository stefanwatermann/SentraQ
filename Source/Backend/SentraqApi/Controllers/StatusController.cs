using System.Reflection;
using System.Runtime.Loader;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/status")]
public class StatusController(
    ILogger<StationController> logger,
    IConfiguration configuration,
    DatabaseContext dbContext,
    StatusFileService statusFileService) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("")]
    public StatusInfo Get()
    {
        return new StatusInfo()
        {
            ApiVersion = Assembly.GetExecutingAssembly().GetName()?.Version?.ToString(),
            ControllerVersion = GetControllerVersion(),
            ControllerUp = IsControllerRunning(),
            LastLogs = GetLastLogs()
        };
    }

    private string GetControllerVersion()
    {
        try
        {
            var assemblyPath = configuration.GetValue<string>("Controller:AssemblyPath") ?? "../controller";
            var name = AssemblyLoadContext.GetAssemblyName($"{assemblyPath}/SentraqController.dll");
            return name.Version != null ? name.Version.ToString() : "unknown";
        }
        catch (Exception e)
        {
            logger.LogError("Failed to get assembly-version of controller.");
            return "failed";
        }
    }

    private bool IsControllerRunning()
    {
        try
        {
            var lastTs = statusFileService.GetLastTimestamp();
            return lastTs > DateTime.Now.AddSeconds(-15);
        }
        catch (Exception e)
        {
            logger.LogError("Failed to read status of controller.");
            return false;
        }
    }

    private string GetLastLogs()
    {
        const int count = 50;
        
        var logs = dbContext
            .Logs
            .AsNoTracking()
            .OrderByDescending(l => l.LogTs)
            .Take(count);
        
        return string.Join('\n', logs.Select(l => 
            l.LogTs.ToString("yyyy-MM-dd HH:mm:ss") + "; " +
            l.Severity + "; " +
            l.Event + "; " +
            l.Message));
    }
}