using SentraqCommon.Services;
using SentraqController.MessageHandler.Handler;
using SentraqModels.Enums;
using SentraqModels.Mqtt;

namespace SentraqController.MessageHandler;

public class MessageHandlerFactory(
    CacheService componentCacheService,
    IServiceProvider serviceProvider,
    ILogger<MessageHandlerFactory> logger)
{
    public IMessageHandler? CreateHandler(MqttPayload payload)
    {
        var component = componentCacheService.GetComponent(payload);
        
        if (component != null)
        {
            switch (component.Type.FromString())
            {
                case ComponentType.Fault:
                    logger.LogDebug("Creating AlertMessageHandler for received message for {uid}.", payload.Hid);
                    return ActivatorUtilities.CreateInstance<AlertMessageHandler>(serviceProvider);
                
                case ComponentType.Actor:
                case ComponentType.Switch:
                    logger.LogDebug("Creating ActorMessageHandler for received message for {uid}.", payload.Hid);
                    return ActivatorUtilities.CreateInstance<ActorMessageHandler>(serviceProvider);
            }
        }

        // no handler found for message-type.
        logger.LogDebug("No message-handler available for received message for {uid}.", payload.Hid);
        return null;
    }
}