// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

public class Aggregation
{
    [MaxLength(36)]
    public required string HardwareId { get; init; }
    
    [Key]
    [Column("date_bin")]
    public DateTime DateBin { get; init; }
    
    [Column("value")]
    public double Value { get; init; }
}