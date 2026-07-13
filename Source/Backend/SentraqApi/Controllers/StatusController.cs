using System.Reflection;
using System.Runtime.Loader;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Services;
using SentraqModels.Api;

namespace SentraqApi.Controllers;

/// <summary>
/// Provides status information of the plattform services.
/// Used by the Frontend to show status information.
/// </summary>
/// <param name="logger"></param>
/// <param name="configuration"></param>
/// <param name="dbContext"></param>
/// <param name="statusFileService"></param>
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
            WatchdogVersion = GetWatchdogVersion(),
            WatchdogUp = IsWatchdogRunning(),
            LastLogs = GetLastLogs()
        };
    }

    private string GetControllerVersion()
    {
        try
        {
            var version = statusFileService.GetVersion("Controller");
            return version;
        }
        catch (Exception e)
        {
            logger.LogError("Failed to get assembly-version of controller.");
            return "failed";
        }
    }
    
    private string GetWatchdogVersion()
    {
        try
        {
            var version = statusFileService.GetVersion("Watchdog");
            return version;
        }
        catch (Exception e)
        {
            logger.LogError("Failed to get assembly-version of watchdog.");
            return "failed";
        }
    }

    private bool IsControllerRunning()
    {
        try
        {
            var lastTs = statusFileService.GetLastTimestamp("Controller");
            return lastTs > DateTime.Now.AddSeconds(-20);
        }
        catch (Exception e)
        {
            logger.LogError("Failed to read status of controller.");
            return false;
        }
    }
    
    private bool IsWatchdogRunning()
    {
        try
        {
            var lastTs = statusFileService.GetLastTimestamp("Watchdog");
            return lastTs > DateTime.Now.AddSeconds(-20);
        }
        catch (Exception e)
        {
            logger.LogError("Failed to read status of watchdog.");
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