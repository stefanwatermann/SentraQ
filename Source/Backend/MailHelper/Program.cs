// #######################################################################################
// Sentraq Backend - Mail-Helper, use this to check mail configuration.
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SentraqCommon.Context;
using SentraqCommon.Security;
using SentraqCommon.Services;

namespace MailHelper;

/// <summary>
/// Helper-programm to test mail-settings of the SentraQ installation. 
/// </summary>
internal static class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("*** SentraQ Mail-Helper ***");

        try
        {
            Console.WriteLine($"CurrentDirectory: {Directory.GetCurrentDirectory()}");
            
            var configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appSettings.json", false)
                .Build();

            var builder = Host.CreateApplicationBuilder(args);
            builder.Services.AddSingleton(configuration);
            builder.Services.AddSingleton<MailService>();
            builder.Services.AddSingleton<SettingService>();
            builder.Services.AddHostedService<Worker>();

            var connStr = configuration.GetConnectionString("DbConnection") ?? 
                          throw new InvalidOperationException("Could not find connection string in appsettings.json");
            
            // configure database access
            builder.Services.AddDbContext<DatabaseContext>(options =>
                options.UseNpgsql(
                    Decrypt.PasswordInConnectionString(
                        connStr, 
                        Secrets.EncryptionPwd))
                    );

            var host = builder.Build();

            host.Run();
        }
        catch (Exception e)
        {
            Console.WriteLine($"ERROR: {e}");
        }
        
        Console.WriteLine($"Done.");
    }
}