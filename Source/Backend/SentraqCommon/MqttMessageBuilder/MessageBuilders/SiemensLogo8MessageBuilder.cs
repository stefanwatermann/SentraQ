using SentraqModels.Data;

namespace SentraqCommon.MqttMessageBuilder.MessageBuilders;

internal class SiemensLogo8MessageBuilder : IMqttMessageBuilder
{
    private const string _messageTemplate = @"{""state"":{""{hardwareId}"":{""value"":[{value}]}}}";

    public string CreatePayloadFor(Component component, string? value)
    {
        var payload = _messageTemplate
            .Replace($"{{hardwareId}}", component.HardwareId)
            .Replace($"{{value}}", value);
        
        return payload;
    }
}