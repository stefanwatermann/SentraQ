using System.Net.Http.Json;
using System.Text.Json;
using SentraqCommon.Context;
using SentraqCommon.Converters;
using SentraqCommon.MqttMessageBuilder;
using SentraqCommon.MqttSender;
using SentraqCommon.Services;
using SentraqController.MessageHandler;
using SentraqModels.Mapper;
using SentraqModels.Mqtt;

namespace SentraqController.Services;

public class PayloadProcessingService(
    ILogger<PayloadProcessingService> logger,
    CacheService componentCacheService,
    SettingService settings,
    MessageHandlerFactory messageHandlerFactory,
    DatabaseContext dbContext,
    MqttMessageBuilderFactory mqttMessageBuilderFactory,
    MqttMessageSender mqttMessageSender
)
{
    /// <summary>
    /// MQTT message payload processing pipeline.
    /// </summary>
    /// <param name="payload"></param>
    public void ProcessPayloads(MqttPayload payload)
    {
        if (!componentCacheService.ComponentExists(payload))
            return;

        FindAndExecuteMessageHandler(payload);

        SaveToDatabase(payload);

        SendToFrontendAsync(payload);

        FindAndExecuteMessageForwarder(payload);
    }

    private void FindAndExecuteMessageHandler(MqttPayload payload)
    {
        try
        {
            // suche passenden Message Handler und führe ihn aus
            messageHandlerFactory.CreateHandler(payload)?.HandleMessage(payload);
        }
        catch (Exception e)
        {
            logger.LogError("Message for {uid} failed to execute message-handler: {e}", payload.Hid, e);
        }
    }

    /// <summary>
    /// Save received message to database.
    /// </summary>
    /// <param name="payload"></param>
    private void SaveToDatabase(MqttPayload payload)
    {
        try
        {
            logger.LogDebug("dbContextId={ctxid}, hid={hid}", dbContext.ContextId, payload.Hid);
            dbContext.Add(EventDataMapper.Map(payload));
            dbContext.SaveChanges(true);
            logger.LogInformation("Message saved for {uid}.", payload.Hid);
        }
        catch (Exception e)
        {
            logger.LogError("Message for {uid} failed writing to database: {e}", payload.Hid, e.Message);
        }
    }

    /// <summary>
    /// Realtime update of component value on frontend UI.
    /// </summary>
    /// <param name="payload"></param>
    private async void SendToFrontendAsync(MqttPayload payload)
    {
        try
        {
            var frontendApiUrl = settings.ControllerFrontendApiUrl;
            var apiAuthKeyValue = settings.ControllerFrontendApiApiAuthKey;
            var url = $"{frontendApiUrl}{payload.Hid}";

            var serializerOptions = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };
            serializerOptions.Converters.Add(new SimpleDateTimeConverter());

            logger.LogDebug("Sending message for {uid} to frontend: {url}", payload.Hid, url);

            var httpClient = new HttpClient();
            httpClient.DefaultRequestHeaders.Add("X-AUTH-KEY", apiAuthKeyValue);
            var response = await httpClient.PostAsJsonAsync(url, payload, serializerOptions);
            response.EnsureSuccessStatusCode();
        }
        catch (Exception e)
        {
            logger.LogError("Message for {uid} failed sending to frontend: {e}", payload.Hid, e.Message);
        }
    }

    /// <summary>
    /// Checks if message need to be forwarded to another HardwareId and forwards the message if so.
    /// </summary>
    /// <param name="receivedPayload"></param>
    private void FindAndExecuteMessageForwarder(MqttPayload receivedPayload)
    {
        try
        {
            var value = Convert.ToString(receivedPayload.Value);
            
            var receivingComponent = componentCacheService.GetComponent(receivedPayload.Hid);
            
            if (receivingComponent is null ||
                string.IsNullOrWhiteSpace(receivingComponent.ForwardToHardwareId) ||
                string.IsNullOrWhiteSpace(value))
                return;

            var sendToComponent = componentCacheService
                                      .GetComponent(receivingComponent.ForwardToHardwareId) ??
                                  throw new NullReferenceException();

            var messageBuilder = mqttMessageBuilderFactory
                .CreateMessageBuilder(sendToComponent.Station.StationControllerTypeName);

            var payload = messageBuilder
                .CreatePayloadFor(sendToComponent, value);

            mqttMessageSender.SendAsync(payload, sendToComponent.Station.Uid);
            
            logger.LogInformation("Value of {value} received from hid={r} forwarded to hid={s}.", 
                value, receivingComponent.HardwareId, sendToComponent.HardwareId);
        }
        catch (Exception ex)
        {
            logger.LogError(
                ex,
                "Failed to forward payload of message Hid={hid}: {error}",
                receivedPayload.Hid,
                ex.Message);
        }
    }
}