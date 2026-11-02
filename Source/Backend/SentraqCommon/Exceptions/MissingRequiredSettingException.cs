// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqCommon.Exceptions;

/// <summary>
/// Raised if a required setting has not been set in the database.
/// </summary>
/// <param name="message">Array of settings that are missing.</param>
public class MissingRequiredSettingException(string[] message) : Exception
{
    public override string Message { get; } = 
        $"One or more required Settings cannot be found or does not have a value. Please add values to: {string.Join(", ", message)}.";
}