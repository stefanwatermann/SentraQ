using Microsoft.Extensions.Logging;
using SentraqCommon.MqttParser.Parsers;

namespace SentraqCommon.MqttParser;

/// <summary>
/// Factory to return the matching parser for a JSON message.
/// </summary>
/// <param name="logger"></param>
public class MqttParserFactory(
    ILogger<MqttParserFactory> logger)
{
    public IMqttParser? CreateParser(string payloadText)
    {
        if (string.IsNullOrWhiteSpace(payloadText))
            throw new ArgumentNullException(nameof(payloadText));

        // Siemens LOGO sends similar: {"state":{"reported":{"0001":{"desc":"M-bit-1-1","value":[1]}}}}
        if (payloadText.Contains("state", StringComparison.InvariantCultureIgnoreCase) && 
            payloadText.Contains("reported", StringComparison.InvariantCultureIgnoreCase))
            return new SiemensLogoParser(payloadText);
        
        // Standard MqttPayload
        if (payloadText.Contains("Hid", StringComparison.InvariantCultureIgnoreCase) && 
            payloadText.Contains("Value", StringComparison.InvariantCultureIgnoreCase))
            return new DefaultParser(payloadText);

        // no parser found. No exception to prevent too much overhead when sender is sending rubbish
        logger.LogWarning("No parser available for received message.");
        return null;
    }
}