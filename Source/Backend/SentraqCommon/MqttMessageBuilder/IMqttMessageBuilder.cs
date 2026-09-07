using SentraqModels.Data;

namespace SentraqCommon.MqttMessageBuilder;

public interface IMqttMessageBuilder
{
    string CreatePayloadFor(Component component, string? value);
}