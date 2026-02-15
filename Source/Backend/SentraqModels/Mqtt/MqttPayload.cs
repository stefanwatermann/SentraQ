namespace SentraqModels.Mqtt;

public class MqttPayload
{
    public string Topic { get; set; }
    public object Value { get; set; }
    public DateTime TS { get; set; }
    public string Hid { get; set; }
}