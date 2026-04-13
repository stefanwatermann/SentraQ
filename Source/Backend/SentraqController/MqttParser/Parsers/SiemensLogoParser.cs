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
        
        // payload needs to have a 'state' and  a 'reported' element.
        var a = nodes["state"]!["reported"]?.AsObject() 
                ?? throw new InvalidDataException();
        
        // if payload does not have a 'desc' and a 'value' element the LOGO is sending in the wrong format
        if (!payloadText.Contains("\"desc\":") && !payloadText.Contains("\"value\":"))
        {
            if (payloadText.Contains("\"$logotime\":"))
                // if payload contains a '$logotime' element just return an empty list
                // therefore single $logotime messages will be ignored
                return payloads;
            else
                throw new InvalidDataException("Invalid payload. Is 'Array Format' activated?");
        }
        
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