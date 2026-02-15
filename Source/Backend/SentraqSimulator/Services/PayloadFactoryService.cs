using SentraqModels.Data;
using SentraqModels.Mqtt;

namespace SentraqSimulator.Services;

public class PayloadFactoryService(Component component)
{
    public MqttPayload CreateMqttPayload(string topic)
    {
        return new MqttPayload()
        {
            Topic = topic,
            Hid = component.HardwareId,
            TS = DateTime.Now,
            Value = CreateRandomValue()
        };
    }

    private object CreateRandomValue()
    {
        var rnd = new Random();
        
        switch (component.Type)
        {
            default: 
                return rnd.Next(component.MinValue, component.MaxValue);
        }
    }
}