// #######################################################################################
// Sentraq Backend - Encryption Helper
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace Encrypt;

/// <summary>
/// Simple helper-project to encrypt secrets used by the SentraQ plattform.
/// </summary>
class Program
{
    static int Main(string[] args)
    {
        Console.WriteLine("*** Encrypt ***");

        if (args.Length != 2)
        {
            Console.WriteLine("Usage: Encrypt <string> <password>");
            return 0;
        }

        try
        {
            Console.WriteLine(SentraqCommon.Security.Encrypt.Text(args[0], args[1]));
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return -1;
        }
        
        return 0;
    }
}