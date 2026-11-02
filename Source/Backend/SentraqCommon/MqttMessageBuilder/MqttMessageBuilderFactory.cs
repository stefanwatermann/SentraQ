// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using Microsoft.Extensions.Logging;
using SentraqCommon.MqttMessageBuilder.MessageBuilders;
using SentraqModels.Enums;

namespace SentraqCommon.MqttMessageBuilder;

public class MqttMessageBuilderFactory(
    ILogger<MqttMessageBuilderFactory> logger)
{
    public IMqttMessageBuilder CreateMessageBuilder(StationControllerType? stationType)
    {
        switch (stationType)
        {
            case StationControllerType.SiemensLogo8:
                return new SiemensLogo8MessageBuilder();
            
            default:
                logger.LogWarning("Station-Type not set, defaulting to SiemensLogo8.");
                return new SiemensLogo8MessageBuilder();
        }
    }
}