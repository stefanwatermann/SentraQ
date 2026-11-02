// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class ComponentExtensions
{
    public static string ReplaceVars(this Component component, string template)
    {
        return template
            .Replace("{Component.HardwareId}", component.HardwareId)
            .Replace("{Component.DisplayName}", component.DisplayName)
            .Replace("{Component.ShortName}", component.ShortName);
    }
}