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
                    return CreateScopedService<AlertMessageHandler>();
                
                case ComponentType.Actor:
                    return CreateScopedService<ActorMessageHandler>();
            }
        }

        // no handler found for message-type.
        logger.LogDebug("No message-handler available for received message for {uid}.", payload.Hid);
        return null;
    }

    private T CreateScopedService<T>() where T : notnull
    {
        var service = serviceProvider.CreateScope().ServiceProvider.GetRequiredService<T>();
        return service;
    }
}