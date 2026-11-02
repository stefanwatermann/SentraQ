// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("Setting")]
public class Setting
{
    [Key]
    public long Id { get; init; }
    
    [MaxLength(100)]
    public required string Key { get; init; }
    
    [MaxLength(2000)]
    public string Value { get; init; } = string.Empty;
}