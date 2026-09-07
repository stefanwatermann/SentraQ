using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.MqttMessageParser;
using SentraqCommon.Security;
using SentraqCommon.Services;

namespace SentraqController.Services;

/// <summary>
/// Listen to the MQTT queue, parse received messages and store them into the database.
/// Sends UI updates also.
/// </summary>
/// <param name="logger"></param>
/// <param name="componentCacheService"></param>
/// <param name="settings"></param>
/// <param name="dbContext"></param>
public class MqttSubscriberWorkerService(
    ILogger<MqttSubscriberWorkerService> logger,
    CacheService componentCacheService,
    SettingService settings,
    MqttMessageParserFactory mqttMessageParserFactory,
    PayloadProcessingService payloadProcessingService) : BackgroundService
{
    private readonly MqttTopicTemplate _topicTemplate = new("/client/send/{clientTopic}");

    private readonly string _brokerHostname = settings.ControllerMqttBrokerHostname;
    private readonly int _tcpPort = settings.ControllerMqttBrokerPort;
    private readonly string _brokerUsername = settings.ControllerMqttBrokerUsername;
    private readonly string _brokerPassword = settings.ControllerMqttBrokerPassword;
    private readonly string _mqttClientTopic = settings.ControllerMqttClientTopic;

    private readonly MqttClientFactory _mqttFactory = new();
    private IMqttClient? _mqttClient;

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        try
        {
            settings.Validate();
            componentCacheService.Init();

            _mqttClient = _mqttFactory.CreateMqttClient();
            _mqttClient.ApplicationMessageReceivedAsync += OnApplicationMessageReceivedAsync;
            _mqttClient.DisconnectedAsync += OnDisconnectedAsync;
            _mqttClient.ConnectingAsync += OnConnectingAsync;
            _mqttClient.ConnectedAsync += OnConnectedAsync;

            await Connect();

            while (!stoppingToken.IsCancellationRequested)
            {
                if (!_mqttClient.IsConnected)
                    await Connect();

                // keep service running
                await Task.Delay(1_000, stoppingToken);
            }
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error in main-loop of MqttSubscriberWorkerService: {m}", e.Message);
            throw;
        }
    }

    private async Task Connect()
    {
        var mqttClientOptions = new MqttClientOptionsBuilder()
            .WithClientId($"wwpsub_{Guid.NewGuid()}")
            .WithTlsOptions(o => { o.UseTls(false); })
            .WithTcpServer(_brokerHostname, _tcpPort)
            .WithCredentials(_brokerUsername, Decrypt.Text(_brokerPassword, Secrets.EncryptionPwd))
            .Build();

        await _mqttClient.ConnectAsync(mqttClientOptions, CancellationToken.None);

        var mqttSubscribeOptions = _mqttFactory.CreateSubscribeOptionsBuilder()
            .WithTopicTemplate(_topicTemplate.WithParameter("clientTopic", _mqttClientTopic)).Build();

        await _mqttClient.SubscribeAsync(mqttSubscribeOptions, CancellationToken.None);
    }

    private Task OnConnectingAsync(MqttClientConnectingEventArgs arg)
    {
        logger.LogInformation("MqttSubscriber connecting to {brokerHostname} ...", _brokerHostname);
        return Task.CompletedTask;
    }

    private Task OnConnectedAsync(MqttClientConnectedEventArgs arg)
    {
        logger.LogInformation("MqttSubscriber connected to {brokerHostname}", _brokerHostname);
        return Task.CompletedTask;
    }

    private Task OnDisconnectedAsync(MqttClientDisconnectedEventArgs arg)
    {
        logger.LogInformation(
            "MqttSubscriber disconnected from {brokerHostname}, reason: {reason}, result: {result}. Reconnecting now.",
            _brokerHostname, arg.Reason, arg.ConnectResult.ResultCode);

        return Connect();
    }

    private Task OnApplicationMessageReceivedAsync(MqttApplicationMessageReceivedEventArgs e)
    {
        e.AutoAcknowledge = true;

        var rawPayload = string.Empty;

        try
        {
            if (e.ApplicationMessage.Payload.Length > 0)
            {
                rawPayload = e.ApplicationMessage.ConvertPayloadToString();

                logger.LogInformation("Message received: {payload}", rawPayload);

                var parser = mqttMessageParserFactory.CreateParser(rawPayload);

                if (parser == null)
                    return Task.CompletedTask;

                var payloads = parser.Convert(e.ApplicationMessage.Topic);

                foreach (var payload in payloads)
                {
                    payloadProcessingService.ProcessPayloads(payload);
                }
            }
        }
        catch (InvalidDataException exception)
        {
            logger.LogWarning(exception.Message, "Unexpected data: " + rawPayload);
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "MQTT client failed while processing message: " + rawPayload);
        }
        finally
        {
            e.ApplicationMessage.Retain = false;
        }

        return Task.CompletedTask;
    }
}