// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqModels.Api;

public class User
{
    public required string Login { get; set; } = string.Empty;
    
    public required string Name { get; set; } = string.Empty;
    
    public required string Hash { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public required string Role { get; set; } = string.Empty;
    
    public string PasskeyIdent { get; set; } = string.Empty;
}