// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using SentraqModels.Data;
using SentraqModels.Helper;

namespace SentraqModels.Extensions;

public static class ComponentViewExtensions
{
    public static string? AdjustedPayload(this ComponentView cv)
    {
        return AdjustmentFunctionCalculator.Calc(cv.AdjustmentFunction, cv.LastPayload);
    }
}