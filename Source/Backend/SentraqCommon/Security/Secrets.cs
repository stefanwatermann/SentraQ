// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqCommon.Security;

public static class Secrets
{
    public static string EncryptionPwd
    {
        get
        {
            // TODO find better way to store encryption password
            const string envKey = "WWP_DEC_CD";
            var pwd = Environment.GetEnvironmentVariable(envKey);
            if (!string.IsNullOrWhiteSpace(pwd))
                return pwd;
            throw new ApplicationException($"Environment variable '{envKey}' not set.");
        }
    }
}