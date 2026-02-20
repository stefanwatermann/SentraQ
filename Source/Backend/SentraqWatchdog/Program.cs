// #######################################################################################
// Sentraq Backend - MQTT Watchdog Service
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqCommon.Security;
using SentraqCommon.Services;
using SentraqWatchdog.Services;

[assembly: AssemblyVersion("1.0.1.*")]

namespace SentraqWatchdog;

/// <summary>
/// Singulärer Watchdog Service.
/// Prüft, ob in der MQTT Eingangstabelle regelmäßig Nachrichten eintreffen.
/// Falls Nachrichten ausbleiben wir ein Alert erzeugt.
/// </summary>
class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("*** Sentraq Watchdog Daemon ***");
        Console.WriteLine($"CurrentDirectory: {Directory.GetCurrentDirectory()}");
        
        var configuration = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", false)
            .Build();

        var connStr = configuration.GetConnectionString("DbConnection") ??
                      throw new InvalidOperationException("Could not find connection string in appsettings.json");
        
        var builder = Host.CreateApplicationBuilder(args);
        
        builder.Services.AddSingleton<IConfiguration>(configuration);
        builder.Services.AddSingleton<SettingService>();
        builder.Services.AddScoped<MqttSenderService>();
        builder.Services.AddScoped<WatchdogService>();
        builder.Services.AddScoped<StatusFileService>();
        builder.Services.AddHostedService<WatchdogWorkerService>();
        
        builder.Services.AddLogging(b =>
        {
            b.ClearProviders();
            b.AddConfiguration(configuration.GetSection("Logging"))
                .AddConsole()
                .AddDebug();
        });
        
        // configure database access
        builder.Services.AddDbContext<DatabaseContext>(options =>
        {
            options.UseNpgsql(Decrypt.PasswordInConnectionString(connStr, Secrets.EncryptionPwd));
            options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
        }, ServiceLifetime.Singleton);

        var host = builder.Build();
        
        host.Run();
    }
}