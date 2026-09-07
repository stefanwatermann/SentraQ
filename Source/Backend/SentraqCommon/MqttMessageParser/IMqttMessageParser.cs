using SentraqModels.Mqtt;

namespace SentraqCommon.MqttMessageParser;

public interface IMqttMessageParser
{
    IEnumerable<MqttPayload> Convert(string topic);
}