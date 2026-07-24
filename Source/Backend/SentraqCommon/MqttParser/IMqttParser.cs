using SentraqModels.Mqtt;

namespace SentraqCommon.MqttParser;

public interface IMqttParser
{
    IEnumerable<MqttPayload> Convert();
}