// #######################################################################################
// Sentraq Backend - MQTT Controller
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;
using SentraqCommon.Security;
using SentraqCommon.Services;
using SentraqController.MessageHandler;
using SentraqController.MessageHandler.Handler;
using SentraqController.MqttParser;
using SentraqController.Services;

[assembly: AssemblyVersion("1.0.1.*")]

namespace SentraqController;

/// <summary>
/// Singulärer MQTT Subscriber Service.
/// Wartet auf eingehende MQTT Nachrichten, parst diese und
/// speichert das Payload in der Datenbank. 
/// </summary>
class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine($"*** SentraQ Controller Worker - v{Assembly.GetExecutingAssembly().GetName()?.Version?.ToString()} ***");
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
        builder.Services.AddScoped<MailService>();
        builder.Services.AddScoped<SmsService>();
        builder.Services.AddScoped<LogService>();
        builder.Services.AddScoped<MqttParserFactory>();
        builder.Services.AddScoped<AlertMessageHandler>();
        builder.Services.AddScoped<ActorMessageHandler>();
        builder.Services.AddScoped<StatusFileService>();
        builder.Services.AddSingleton<MessageHandlerFactory>();
        builder.Services.AddSingleton<CacheService>();
        builder.Services.AddHostedService<MqttSubscriberWorkerService>();
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
        });

        var host = builder.Build();
        
        host.Run();
    }
}