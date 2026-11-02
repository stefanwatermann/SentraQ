// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("vStation")]
public class StationView : Station
{
    public bool HasActiveAlert { get; init; }
}