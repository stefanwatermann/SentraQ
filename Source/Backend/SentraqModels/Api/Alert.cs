// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Api;

public class Alert
{
    public required string StationUid { get; init; } = string.Empty;
    
    public string StationShortName { get; init; } = string.Empty;
    
    public DateTime? ConfirmedAt { get; set; }
    
    public string? ConfirmedBy { get; set; }
    
    public DateTime? MailSendAt { get; set; }
    
    public DateTime? FirstEventTs { get; set; }
    
    public DateTime? LastEventTs { get; set; }
    
    public bool IsActive { get; set; } 
    
    public string? Faults { get; set; }
}