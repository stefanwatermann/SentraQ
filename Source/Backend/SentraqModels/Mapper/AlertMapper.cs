namespace SentraqModels.Mapper;

public static class AlertMapper
{
    public static Api.Alert Map(Data.Alert alert)
    {
        return new Api.Alert()
        {
            StationUid = alert.StationUid,
            ConfirmedBy = alert.ConfirmedBy,
            ConfirmedAt = alert.ConfirmedAt,
            IsActive = alert.IsActive,
            FirstEventTs = alert.FirstEventTs,
            LastEventTs = alert.LastEventTs,
            MailSendAt = alert.MailSendAt
        };
    }
}