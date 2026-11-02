// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Mqtt;

public class MqttPayload
{
    public string Topic { get; set; }
    public object Value { get; set; }
    public DateTime TS { get; set; }
    public string Hid { get; set; }

    public override string ToString()
    {
        return $"Topic={Topic}, Value={Value}, TS={TS}, Hid={Hid}";
    }
}