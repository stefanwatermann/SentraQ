// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Mapper;

public static class LogMapper
{
    public static Api.Log Map(Data.Log log)
    {
        return new Api.Log()
        {
            Severity = log.Severity,
            EventType = log.Event,
            LogTs = log.LogTs,
            Message = log.Message
        };
    }
}