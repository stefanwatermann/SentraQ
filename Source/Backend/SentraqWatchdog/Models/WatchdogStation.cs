// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqWatchdog.Models;

internal class WatchdogStation
{
    public string StationUid { get; init; }
    public string WatchdogHardwareId { get; init; }
    public DateTime LastReceivedTs { get; init; }
}