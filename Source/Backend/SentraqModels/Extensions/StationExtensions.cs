// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class StationExtensions
{
    public static bool InMaintenance(this Station station)
    {
        return station.MaintenanceActiveSinceTs.HasValue;
    }
    
    public static string ReplaceVars(this Station station, string template)
    {
        return template
            .Replace("{Station.Uid}", station.Uid)
            .Replace("{Station.ShortName}", station.ShortName)
            .Replace("{Station.DisplayName}", station.DisplayName);
    }
}