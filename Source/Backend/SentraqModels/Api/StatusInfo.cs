// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Api;

public class StatusInfo
{
    public string? ApiVersion { get; set; }
    public string? ControllerVersion { get; set; }
    public bool ControllerUp { get; set; }
    public string? WatchdogVersion { get; set; }
    public bool WatchdogUp { get; set; }
}