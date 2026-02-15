using SentraqModels.Mqtt;

namespace SentraqController.MqttParser;

public interface IMqttParser
{
    IEnumerable<MqttPayload> Convert();
}