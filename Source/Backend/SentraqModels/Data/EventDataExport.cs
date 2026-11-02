// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SentraqModels.Data;

[Table("vEventDataExport")]
[Keyless]
public class EventDataExport
{
    public required string StationName { get; init; }
    
    public required string StationUid { get; init; }
    
    public required string ComponentName { get; init; }
    
    public required string HardwareId { get; init; }
    
    public required string ComponentType { get; init; }
    
    public required DateTime Received { get; init; }
    
    public string? Unit { get; init; }
    
    public double Value { get; init; }
}