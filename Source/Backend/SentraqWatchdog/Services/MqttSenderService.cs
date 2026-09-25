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
    private IMqttClient _mqttClient;
    private string _payloadString;
    
    public async Task Send(MqttPayload payload)
    {
        var mqttFactory = new MqttClientFactory();

        _mqttClient = mqttFactory.CreateMqttClient();
        _mqttClient.ConnectedAsync += MqttClientOnConnectedAsync;
        _mqttClient.ConnectingAsync += MqttClientOnConnectingAsync;
        _mqttClient.DisconnectedAsync += MqttClientOnDisconnectedAsync;
        
        var serializerOptions = new JsonSerializerOptions();
        serializerOptions.Converters.Add(new SimpleDateTimeConverter());
        _payloadString = JsonSerializer.Serialize(payload, serializerOptions);
        
        var mqttClientOptions = new MqttClientOptionsBuilder()
            .WithClientId(Guid.NewGuid().ToString())
            .WithTlsOptions(o => { o.UseTls(false); })
            .WithTcpServer(settings.ControllerMqttBrokerHostname, settings.ControllerMqttBrokerPort)
            .WithCredentials(settings.ControllerMqttBrokerUsername, Decrypt.Text(settings.ControllerMqttBrokerPassword, Secrets.EncryptionPwd))
            .Build();

        await _mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);
    }

    private Task MqttClientOnDisconnectedAsync(MqttClientDisconnectedEventArgs arg)
    {
        var err = arg.Exception != null ? ", Exception: " + arg.Exception.Message : string.Empty;
        var result = arg.ConnectResult != null ? arg.ConnectResult.ResultCode.ToString() : string.Empty;
        logger.LogDebug("MQTT client disconnected. {result}, reason: {reason}{err}", result, arg.ReasonString, err);
        return Task.CompletedTask;
    }

    private Task MqttClientOnConnectingAsync(MqttClientConnectingEventArgs arg)
    {
        logger.LogDebug("MQTT client connecting to {brokerHostname} ...", settings.ControllerMqttBrokerHostname);
        return Task.CompletedTask;
    }

    private Task MqttClientOnConnectedAsync(MqttClientConnectedEventArgs arg)
    {
        logger.LogInformation($"MQTT client connected, now sending payload: {_payloadString}");
        
        var applicationMessage = new MqttApplicationMessageBuilder()
            .WithTopicTemplate(_topicTemplate.WithParameter("clientTopic", settings.ControllerMqttClientTopic))
            .WithPayload(_payloadString)
            .Build();
        
        var result = _mqttClient.PublishAsync(applicationMessage, CancellationToken.None).Result;

        _mqttClient.DisconnectAsync().Wait();
        
        return Task.CompletedTask;
    }
}