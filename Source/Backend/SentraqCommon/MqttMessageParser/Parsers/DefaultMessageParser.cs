using System.Text.Json;
using SentraqCommon.Converters;
using SentraqModels.Mqtt;

namespace SentraqCommon.MqttMessageParser.Parsers;

/// <summary>
/// Parser for the Sentraq JSON message format.
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