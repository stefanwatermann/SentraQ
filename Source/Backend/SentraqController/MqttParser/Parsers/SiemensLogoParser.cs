using System.Text.Json.Nodes;
using SentraqModels.Mqtt;

namespace SentraqController.MqttParser.Parsers;

internal class SiemensLogoParser(string payloadText) : IMqttParser
{
    /// <summary>
    /// Siemens LOGO8 Format, Beispiel: {"state":{"reported":{"0001":{"desc":"M-bit-1-1","value":[1]}}}}
    /// Daten werden im "Array-Format" erwartet.
    /// </summary>
    /// <returns></returns>
    /// <exception cref="ArgumentNullException"></exception>
    public IEnumerable<MqttPayload> Convert()
    {
        var payloads = new List<MqttPayload>();
        
        var nodes = JsonNode.Parse(payloadText) 
                    ?? throw new ArgumentNullException();
        
        if (!payloadText.Contains("\"desc\":"))
            throw new InvalidDataException("Invalid payload. Is 'Array Format' activated?");
        
        var a = nodes["state"]!["reported"]?.AsObject() 
                ?? throw new ArgumentNullException();
        
        foreach (var o in a)
        {
            if (o.Key.Equals("$logotime"))
                // $logotime wird hier ignoriert, da nicht sichergestellt ist, dass das Element als Erstes auftaucht
                continue;
            
            var data = o.Value?.AsObject()
                       ?? throw new ArgumentNullException();
            
            var description = data["desc"];
            
            payloads.Add(new MqttPayload()
            {
                Hid = o.Key,
                Value = data["value"][0],
                TS = DateTime.Now
            });
        }
        
        return payloads.AsEnumerable();
    }
}