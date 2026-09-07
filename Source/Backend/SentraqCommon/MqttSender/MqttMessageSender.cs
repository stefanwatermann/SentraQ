using System.Text.Json;
using Microsoft.Extensions.Logging;
using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.Converters;
using SentraqCommon.Security;
using SentraqCommon.Services;

namespace SentraqCommon.MqttSender;

/// <summary>
/// Used to send values to components, e.g. to turn real switches on or off.
/// </summary>
public class MqttMessageSender(
    ILogger<MqttMessageSender> logger,
    SettingService settings)
{
    private readonly MqttTopicTemplate _topicTemplate = new("/client/receive/{clientTopic}/{stationUid}");
    
    public async void SendAsync(string payload, string stationUid)
    {
        var topic = _topicTemplate
            .WithParameter("clientTopic", settings.ControllerMqttClientTopic)
            .WithParameter("stationUid", stationUid);
            
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
            .WithTopicTemplate(topic)
            .WithPayload(payload)
            .Build();

        logger.LogDebug("MQTT client connecting to {brokerHostname} ...", settings.ControllerMqttBrokerHostname);

        await mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);
    
        logger.LogInformation($"Sending payload '{payload}' to topic '{topic}'.");
    
        await mqttClient.PublishAsync(applicationMessage, CancellationToken.None);

        await mqttClient.DisconnectAsync();

        logger.LogDebug("MQTT client disconnected.");
    }
}