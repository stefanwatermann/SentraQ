// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Enums;

public enum CounterType
{
    // Counter adds time between two payloads
    timediff,
    
    // Counter adds value of payloads
    valueadd
}