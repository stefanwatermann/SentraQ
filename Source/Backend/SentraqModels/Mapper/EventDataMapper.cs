// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Data;
using SentraqModels.Mqtt;

namespace SentraqModels.Mapper;

public static class EventDataMapper
{
    public static EventData Map(MqttPayload mqttPayload)
    {
        return new EventData()
        {
            CreateTs = mqttPayload.TS,
            Payload = Convert.ToString(mqttPayload.Value),
            ReceivedTs = DateTime.Now,
            HardwareId = mqttPayload.Hid
        };
    }
    
    public static Api.EventData Map(EventData eventData)
    {
        return new Api.EventData()
        {
            CreateTs = eventData.CreateTs,
            Payload = eventData.Payload,
            ReceivedTs = eventData.ReceivedTs,
            HardwareId = eventData.HardwareId
        };
    }
    
    public static Api.EventDataExport Map(EventDataExport eventData)
    {
        return new Api.EventDataExport()
        {
            StationName = eventData.StationName,
            StationUid = eventData.StationUid,
            Received = eventData.Received,
            ComponentName = eventData.ComponentName,
            ComponentType = eventData.ComponentType,
            Value = eventData.Value,
            Unit = eventData.Unit,
            HardwareId = eventData.HardwareId
        };
    }
}