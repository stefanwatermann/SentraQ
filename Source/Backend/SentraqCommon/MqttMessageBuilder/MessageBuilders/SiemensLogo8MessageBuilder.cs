// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Data;

namespace SentraqCommon.MqttMessageBuilder.MessageBuilders;

internal class SiemensLogo8MessageBuilder : IMqttMessageBuilder
{
    private const string _messageTemplate = @"{""state"":{""{hardwareId}"":{""value"":[{value}]}}}";

    public string CreatePayloadFor(Component component, string? value)
    {
        var payload = _messageTemplate
            .Replace($"{{hardwareId}}", component.HardwareId)
            .Replace($"{{value}}", value);
        
        return payload;
    }
}