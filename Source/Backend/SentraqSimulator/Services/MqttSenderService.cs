using System.Text.Json;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.Converters;
using SentraqModels.Data;
using SentraqModels.Mqtt;

namespace SentraqSimulator.Services;

public class MqttSenderService(
    ILogger<Worker> logger,
    IConfiguration config,
    Component component)
{
    private readonly MqttTopicTemplate _topicTemplate = new("client/send/{clientTopic}");
    
    private readonly string _brokerHostname = config.GetValue<string>("Mqtt:Broker:Hostname", string.Empty);
    private readonly int _tcpPort = config.GetValue<int>("Mqtt:Broker:Port");
    private readonly string _brokerUsername = config.GetValue<string>("Mqtt:Broker:Username", string.Empty);
    private readonly string _brokerPassword = config.GetValue<string>("Mqtt:Broker:Password", string.Empty);
    private readonly string _mqttClientTopic = config.GetValue<string>("Mqtt:ClientTopic", string.Empty);
    
    public void Execute()
    {
        logger.LogInformation("Starting MQTT client for component '" + component.ShortName + "' (" + component.HardwareId + ")");

        var payloadFactory = new PayloadFactoryService(component);
        var payload = payloadFactory.CreateMqttPayload(_mqttClientTopic);
        
        SendAsync(payload);
    }
    
    public async void SendAsync(MqttPayload payload)
    {
        var mqttFactory = new MqttClientFactory();

        using var mqttClient = mqttFactory.CreateMqttClient();
        
        var mqttClientOptions = new MqttClientOptionsBuilder()
            .WithClientId(Guid.NewGuid().ToString())
            .WithTlsOptions(o => { o.UseTls(false); })
            .WithTcpServer(_brokerHostname, _tcpPort)
            .WithCredentials(_brokerUsername, _brokerPassword)
            .Build();
        
        logger.LogDebug("MQTT client connecting to {brokerHostname} ...", _brokerHostname);

        await mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);
        
        var serializerOptions = new JsonSerializerOptions();
        serializerOptions.Converters.Add(new SimpleDateTimeConverter());
        
        logger.LogDebug($"MQTT client connected, now sending payload: {JsonSerializer.Serialize(payload)}");
    
        var applicationMessage = new MqttApplicationMessageBuilder()
            .WithTopicTemplate(_topicTemplate.WithParameter("clientTopic", _mqttClientTopic))
            .WithPayload(JsonSerializer.Serialize(payload, serializerOptions))
            .Build();

        await mqttClient.PublishAsync(applicationMessage, CancellationToken.None);

        await mqttClient.DisconnectAsync();

        logger.LogDebug("MQTT client disconnected.");
    }
}