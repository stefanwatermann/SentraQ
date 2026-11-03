using System.Reflection;
using Microsoft.AspNetCore.Mvc;
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
    StatusFileService statusFileService) : ControllerBase
{
    [HttpGet("")]
    public StatusInfo Get()
    {
        var status = new StatusInfo()
        {
            ApiVersion = Assembly.GetExecutingAssembly().GetName()?.Version?.ToString(),
            ControllerVersion = GetControllerVersion(),
            ControllerUp = IsControllerRunning(),
            WatchdogVersion = GetWatchdogVersion(),
            WatchdogUp = IsWatchdogRunning()
        };
        return status;
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
            logger.LogError("Failed to get assembly-version of controller. {e}", e.Message);
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
            logger.LogError("Failed to get assembly-version of watchdog. {e}", e.Message);
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
            logger.LogError("Failed to read status of controller. {e}", e.Message);
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
            logger.LogError("Failed to read status of watchdog. {e}", e.Message);
            return false;
        }
    }
}