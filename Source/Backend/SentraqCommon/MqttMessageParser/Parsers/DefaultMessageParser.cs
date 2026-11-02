// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Text.Json;
using SentraqCommon.Converters;
using SentraqModels.Mqtt;

namespace SentraqCommon.MqttMessageParser.Parsers;

/// <summary>
/// Parser for Sentraq JSON message format:
/// {
///  "Value": 1,
///  "Hid": "[hardwareId]",
///  "TS": "[timestamp: yyyy-MM-dd HH:mm:ss]" 
/// }
/// </summary>
/// <param name="payloadText">JSON payload</param>
internal class DefaultMessageParser(string payloadText) : IMqttMessageParser
{
    public IEnumerable<MqttPayload> Convert(string topic)
    {
        var serializerOptions = new JsonSerializerOptions();
        serializerOptions.Converters.Add(new SimpleDateTimeConverter());

        IEnumerable<MqttPayload> payloads; 

        if (payloadText.StartsWith("[") && payloadText.EndsWith("]"))
        {
            // payload array received
            payloads = JsonSerializer.Deserialize<MqttPayload[]>(payloadText, serializerOptions) ?? 
                       throw new Exception("Payload is null");
        }
        else
        {
            // single payload received   
            payloads =new [] { JsonSerializer.Deserialize<MqttPayload>(payloadText, serializerOptions) ?? 
                               throw new Exception("Payload is null") };
        }

        foreach (var payload in payloads)
        {
            payload.Topic = topic;
        }

        return payloads;
    }
}