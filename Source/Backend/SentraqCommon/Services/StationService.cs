using Microsoft.Extensions.Logging;
using SentraqCommon.Context;

namespace SentraqCommon.Services;

public class StationService(
    ILogger<StationService> logger,
    LogService logService,
    DatabaseContext dbContext)
{
    public void ClearAlert(string stationUid, string user)
    {
        var alert = dbContext
            .Alerts
            .FirstOrDefault(a => a.StationUid == stationUid && a.IsActive == "Y");

        if (alert is null)
            return;

        alert.ConfirmedAt = DateTime.Now;
        alert.ConfirmedBy = user;
        
        logService.AddInfo(LogService.Event.AlertAction,$"Alert for station {stationUid} cleared by {user}");
        
        dbContext.SaveChanges(true);
    }
}