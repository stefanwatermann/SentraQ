// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using SentraqModels.Enums;

namespace SentraqModels.Data;

[Table("Counter")]
public class Counter
{
    [Key] 
    public long Id { get; init; }

    [MaxLength(36)] 
    public required string HardwareId { get; init; } = string.Empty;
    
    [MaxLength(250)]
    public required string DisplayName { get; set; }
    
    [MaxLength(50)]
    public required string ShortName { get; set; }
    
    [MaxLength(50)]
    public string? DisplayUnit { get; set; }
    
    public int? DisplayOrder { get; set; }
    
    [MaxLength(50)]
    public string? AdjustmentFunction { get; set; }
    
    public DateTime? LastTs { get; set; }
    
    public int LastValue { get; set; } = 0;
    
    public long Count { get; set; } = 0;
    
    public bool Removed { get; set; }
    
    public bool Visible { get; set; }
    
    public CounterType Type { get; set; }
}