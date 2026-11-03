// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Text.Json;
using Microsoft.Extensions.Logging;
using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.Converters;
using SentraqCommon.Security;
using SentraqCommon.Services;
using SentraqModels.Mqtt;

namespace SentraqWatchdog.Services;

public class MqttSenderService
{
    private readonly MqttTopicTemplate _topicTemplate = new("/client/send/{clientTopic}");
    private readonly IMqttClient _mqttClient;
    private readonly ILogger<MqttSenderService> _logger;
    private readonly SettingService _settings;
    
    private string _payloadString = string.Empty;
    
    public MqttSenderService(
        ILogger<MqttSenderService> logger,
        SettingService settings)
    {
        _logger = logger;
        _settings = settings;
        
        var mqttFactory = new MqttClientFactory();
        _mqttClient = mqttFactory.CreateMqttClient();
        _mqttClient.ConnectedAsync += MqttClientOnConnectedAsync;
        _mqttClient.ConnectingAsync += MqttClientOnConnectingAsync;
        _mqttClient.DisconnectedAsync += MqttClientOnDisconnectedAsync;
    }
    
    public async Task Send(MqttPayload payload)
    {
        var serializerOptions = new JsonSerializerOptions();
        serializerOptions.Converters.Add(new SimpleDateTimeConverter());
        _payloadString = JsonSerializer.Serialize(payload, serializerOptions);
        
        var mqttClientOptions = new MqttClientOptionsBuilder()
            .WithClientId(Guid.NewGuid().ToString())
            .WithTlsOptions(o => { o.UseTls(false); })
            .WithTcpServer(_settings.ControllerMqttBrokerHostname, _settings.ControllerMqttBrokerPort)
            .WithCredentials(_settings.ControllerMqttBrokerUsername, Decrypt.Text(_settings.ControllerMqttBrokerPassword, Secrets.EncryptionPwd))
            .Build();

        await _mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);
    }

    private Task MqttClientOnDisconnectedAsync(MqttClientDisconnectedEventArgs arg)
    {
        var err = arg.Exception != null ? ", Exception: " + arg.Exception.Message : string.Empty;
        var result = arg.ConnectResult != null ? arg.ConnectResult.ResultCode.ToString() : string.Empty;
        _logger.LogDebug("MQTT client disconnected. {result}, reason: {reason}{err}", result, arg.ReasonString, err);
        return Task.CompletedTask;
    }

    private Task MqttClientOnConnectingAsync(MqttClientConnectingEventArgs arg)
    {
        _logger.LogDebug("MQTT client connecting to {brokerHostname} ...", _settings.ControllerMqttBrokerHostname);
        return Task.CompletedTask;
    }

    private Task MqttClientOnConnectedAsync(MqttClientConnectedEventArgs arg)
    {
        _logger.LogInformation($"MQTT client connected, now sending payload: {_payloadString}");
        
        var applicationMessage = new MqttApplicationMessageBuilder()
            .WithTopicTemplate(_topicTemplate.WithParameter("clientTopic", _settings.ControllerMqttClientTopic))
            .WithPayload(_payloadString)
            .Build();
        
        var result = _mqttClient.PublishAsync(applicationMessage, CancellationToken.None).Result;

        _mqttClient.DisconnectAsync().Wait();
        
        return Task.CompletedTask;
    }
}