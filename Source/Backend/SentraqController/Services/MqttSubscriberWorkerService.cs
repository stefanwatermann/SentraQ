using System.Net.Http.Json;
using System.Text.Json;
using MQTTnet;
using MQTTnet.Extensions.TopicTemplate;
using SentraqCommon.Context;
using SentraqCommon.Converters;
using SentraqCommon.MqttParser;
using SentraqCommon.Security;
using SentraqCommon.Services;
using SentraqController.MessageHandler;
using SentraqModels.Mapper;
using SentraqModels.Mqtt;

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
    MqttParserFactory mqttParserFactory,
    MessageHandlerFactory messageHandlerFactory,
    DatabaseContext dbContext) : BackgroundService
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
        logger.LogInformation("MqttSubscriber disconnected from {brokerHostname}, reason: {reason}, result: {result}. Reconnecting now.",
            _brokerHostname, arg.Reason, arg.ConnectResult.ResultCode);
        
        return Connect();
    }

    private Task OnApplicationMessageReceivedAsync(MqttApplicationMessageReceivedEventArgs e)
    {
        e.AutoAcknowledge = true;

        var payloadText = string.Empty;

        try
        {
            if (e.ApplicationMessage.Payload.Length > 0)
            {
                payloadText = e.ApplicationMessage.ConvertPayloadToString();

                logger.LogInformation("Message received: {payload}", payloadText);

                var parser = mqttParserFactory.CreateParser(payloadText);

                if (parser == null)
                    return Task.CompletedTask;

                var payloads = parser.Convert();

                foreach (var payload in payloads)
                {
                    
                    if (!componentCacheService.ComponentExists(payload))
                        continue;

                    payload.Topic = e.ApplicationMessage.Topic;

                    FindAndExecuteMessageHandler(payload);

                    SaveToDatabase(payload);

                    SendToFrontendAsync(payload);
                }
            }
        }
        catch (InvalidDataException exception)
        {
            logger.LogWarning(exception.Message, "Unexpected data: " + payloadText);
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "MQTT client failed while processing message: " + payloadText);
        }
        finally
        {
            e.ApplicationMessage.Retain = false;
        }

        return Task.CompletedTask;
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
}