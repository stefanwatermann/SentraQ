// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Api;

public class EventData
{
    public required string HardwareId { get; init; }
    
    public DateTime CreateTs { get; init; }
    
    public DateTime ReceivedTs { get; set; }
    
    public string? Payload { get; init; }
}