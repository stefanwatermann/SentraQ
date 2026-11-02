// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Internal;

public class PayloadLastValueCache
{
    public required string HardwareId { get; init; }
    public required string LastPayload { get; set; } = string.Empty;
    public required DateTime LastChangedTs { get; set; }
}