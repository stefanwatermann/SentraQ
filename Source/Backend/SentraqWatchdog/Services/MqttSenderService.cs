using System.Text.Json;
using Microsoft.Extensions.Logging;
using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.Converters;
using SentraqCommon.Security;
using SentraqCommon.Services;
using SentraqModels.Mqtt;

namespace SentraqWatchdog.Services;

public class MqttSenderService(
    ILogger<MqttSenderService> logger,
    SettingService settings)
{
    private readonly MqttTopicTemplate _topicTemplate = new("/client/send/{clientTopic}");
    
    public async void Send(MqttPayload payload)
    {
        var mqttFactory = new MqttClientFactory();

        using var mqttClient = mqttFactory.CreateMqttClient();
        
        var mqttClientOptions = new MqttClientOptionsBuilder()
            .WithClientId(Guid.NewGuid().ToString())
            .WithTlsOptions(o => { o.UseTls(false); })
            .WithTcpServer(settings.ControllerMqttBrokerHostname, settings.ControllerMqttBrokerPort)
            .WithCredentials(settings.ControllerMqttBrokerUsername, Decrypt.Text(settings.ControllerMqttBrokerPassword, Secrets.EncryptionPwd))
            .Build();
        
        var serializerOptions = new JsonSerializerOptions();
        serializerOptions.Converters.Add(new SimpleDateTimeConverter());
    
        var applicationMessage = new MqttApplicationMessageBuilder()
            .WithTopicTemplate(_topicTemplate.WithParameter("clientTopic", settings.ControllerMqttClientTopic))
            .WithPayload(JsonSerializer.Serialize(payload, serializerOptions))
            .Build();

        logger.LogDebug("MQTT client connecting to {brokerHostname} ...", settings.ControllerMqttBrokerHostname);

        await mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);
        
        logger.LogInformation($"MQTT client connected, now sending payload: {JsonSerializer.Serialize(payload)}");
        
        await mqttClient.PublishAsync(applicationMessage, CancellationToken.None);

        await mqttClient.DisconnectAsync();

        logger.LogDebug("MQTT client disconnected.");
    }
}