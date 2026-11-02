// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Data;

namespace SentraqCommon.MqttMessageBuilder;

public interface IMqttMessageBuilder
{
    string CreatePayloadFor(Component component, string? value);
}