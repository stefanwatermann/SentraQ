using System.Globalization;
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
    private readonly string _filePathName = configuration["Controller:StatusFile"] ?? "status-file.txt";

    public void Keepalive()
    {
        try
        {
            File.WriteAllText(_filePathName, DateTime.Now.ToString("yyyyMMdd-HHmmss"));
        }
        catch (Exception e)
        {
            logger.LogError("StatusFileService: Cannot update status-file {file}: {e}", _filePathName, e);
        }
    }

    public DateTime GetLastTimestamp()
    {
        if (!File.Exists(_filePathName))
            return DateTime.MinValue;
        var data = File.ReadAllText(_filePathName);
        var timestamp = DateTime.ParseExact(data, "yyyyMMdd-HHmmss", CultureInfo.InvariantCulture);
        return timestamp;
    }
}