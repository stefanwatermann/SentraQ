using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler;

public interface IMessageHandler
{
    void HandleMessage(MqttPayload payload);
}