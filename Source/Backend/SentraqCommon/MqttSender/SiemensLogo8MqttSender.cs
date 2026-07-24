using System.Text.Json;
using Microsoft.Extensions.Logging;
using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.Converters;
using SentraqCommon.Security;
using SentraqCommon.Services;
using SentraqModels.Data;

namespace SentraqCommon.MqttSender;

/// <summary>
/// Used to send values to components, e.g. to turn real switches on or off.
/// Siemens LOGO8 format only.
/// </summary>
public class SiemensLogo8MqttSender(
    ILogger<SiemensLogo8MqttSender> logger,
    SettingService settings)
{
    private const string _messageTemplate = @"{""state"":{""{hardwareId}"":{""value"":[{value}]}}}";
    private readonly MqttTopicTemplate _topicTemplate = new("/client/receive/{clientTopic}/{stationUid}");
    
    public async void Send(Component component, string value)
    {
        var payload = _messageTemplate
            .Replace($"{{hardwareId}}", component.HardwareId)
            .Replace($"{{value}}", value);

        var topic = _topicTemplate
            .WithParameter("clientTopic", settings.ControllerMqttClientTopic)
            .WithParameter("stationUid", component.Station.Uid);
            
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