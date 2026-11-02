// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
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