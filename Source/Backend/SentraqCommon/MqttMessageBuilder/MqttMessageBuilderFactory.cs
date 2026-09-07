using Microsoft.Extensions.Logging;
using SentraqCommon.MqttMessageBuilder.MessageBuilders;
using SentraqModels.Enums;

namespace SentraqCommon.MqttMessageBuilder;

public class MqttMessageBuilderFactory(
    ILogger<MqttMessageBuilderFactory> logger)
{
    public IMqttMessageBuilder CreateMessageBuilder(StationControllerType? stationType)
    {
        switch (stationType)
        {
            case StationControllerType.SiemensLogo8:
                return new SiemensLogo8MessageBuilder();
            
            default:
                logger.LogWarning("Station-Type not set, defaulting to SiemensLogo8.");
                return new SiemensLogo8MessageBuilder();
        }
    }
}