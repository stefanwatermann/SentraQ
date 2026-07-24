using System.Globalization;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace SentraqCommon.Services;

/// <summary>
/// Simple approach to check that a service is running.
/// Updates a timestamp in a file frequently, so that
/// someone else can see that the service is active
/// (since the timestamp is not too old).
/// </summary>
public class StatusFileService(
    IConfiguration configuration,
    ILogger<StatusFileService> logger)
{
    public void Keepalive(string cfg)
    {
        var filePathName = configuration["{cfg}:StatusFile".Replace("{cfg}", cfg)] ?? "status-file.txt";
        try
        {
            File.WriteAllText(filePathName, DateTime.Now.ToString("yyyyMMdd-HHmmss"));
        }
        catch (Exception e)
        {
            logger.LogError("StatusFileService: Cannot update status-file {file}: {e}", filePathName, e);
        }
    }
    
    /// <summary>
    /// Writes the assembly-version of the current app to a file.
    /// Will be read from Api to display the version on teh Frontend.
    /// </summary>
    /// <param name="cfg"></param>
    public void WriteVersionFile(string cfg)
    {
        var filePathName = configuration["{cfg}:StatusFile".Replace("{cfg}", cfg)] ?? "version.txt";
        try
        {
            var version = Assembly.GetEntryAssembly()?.GetName().Version?.ToString() ?? "unknown";
            File.WriteAllText(filePathName, $"{version}");
        }
        catch (Exception e)
        {
            logger.LogError("StatusFileService: Cannot update version file {file}: {e}", filePathName, e);
        }
    }

    /// <summary>
    /// Returns the version from the corresponding version file
    /// </summary>
    /// <param name="cfg"></param>
    /// <returns></returns>
    public string GetVersion(string cfg)
    {
        var filePathName = configuration["{cfg}:StatusFile".Replace("{cfg}", cfg)] ?? "version.txt";
        if (!File.Exists(filePathName))
            return "missing";
        var data = File.ReadAllText(filePathName);
        return data;
    }
    
    public DateTime GetLastTimestamp(string cfg)
    {
        var filePathName = configuration["{cfg}:StatusFile".Replace("{cfg}", cfg)] ?? "status-file.txt";
        if (!File.Exists(filePathName))
            return DateTime.MinValue;
        var data = File.ReadAllText(filePathName);
        var timestamp = DateTime.ParseExact(data, "yyyyMMdd-HHmmss", CultureInfo.InvariantCulture);
        return timestamp;
    }
}