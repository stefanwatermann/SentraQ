namespace SentraqModels.Mapper;

public static class AlertMapper
{
    public static Api.Alert Map(Data.AlertView alert)
    {
        return new Api.Alert()
        {
            StationUid = alert.StationUid,
            StationShortName = alert.StationShortName,
            ConfirmedBy = alert.ConfirmedBy,
            ConfirmedAt = alert.ConfirmedAt,
            IsActive = alert.IsActive == "Y",
            FirstEventTs = alert.FirstEventTs,
            LastEventTs = alert.LastEventTs,
            MailSendAt = alert.MailSendAt,
            Faults = alert.Faults
        };
    }
}