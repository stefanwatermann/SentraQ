using System.Text.Json;
using SentraqCommon.Converters;
using SentraqModels.Mqtt;

namespace SentraqController.MqttParser.Parsers;

internal class DefaultParser(string payloadText) : IMqttParser
{
    public IEnumerable<MqttPayload> Convert()
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

        return payloads;
    }
}