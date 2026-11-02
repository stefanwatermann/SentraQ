// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Api;

public class Station
{
    public string? Uid { get; init; }
    
    public required string DisplayName { get; init; }
    
    public required string ShortName { get; init; }
        
    public required decimal Latitude { get; init; }
    public required decimal Longitude { get; init; }
    
    public required string Type { get; init; }
        
    public string? DisplayColor { get; init; }
    
    public int? DisplayOrder { get; init; }
    
    public string? WatchdogHardwareId { get; init; }
    
    public bool HasActiveAlert { get; init; } = false;
    
    public DateTime? MaintenanceActiveSinceTs { get; set; }
    
    public bool Removed { get; set; }
    
    public bool Visible { get; set; }
    
    public string? AlertReceiverEmailAddresses { get; init; }
}