// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqCommon.Exceptions;

/// <summary>
/// Raised if a password reste-code is invalid or expired.
/// </summary>
public class PasswordResetCodeInvalidOrExpiredException() :
    Exception("Der Passwort-Code ist ungültig oder abgelaufen.");