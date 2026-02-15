// #######################################################################################
// Sentraq Backend - MQTT Message Simulator
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SentraqSimulator.Contexts;
using SentraqSimulator.Services;

namespace SentraqSimulator;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("*** Wasserwerk Plattform Simulator ***");
        
        var configuration = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appSettings.json", false)
            .Build();
        
        var builder = Host.CreateApplicationBuilder(args);
        builder.Services.AddSingleton(configuration);
        builder.Services.AddSingleton<LoadSimulatorService>();
        builder.Services.AddSingleton<CounterTestService>();
        builder.Services.AddHostedService<Worker>();
        
        // configure database access
        builder.Services.AddDbContext<WwpDatabaseContext>(options => 
            options.UseNpgsql(
                configuration.GetConnectionString("WwpDbConnection")));

        var host = builder.Build();
        
        host.Run();
    }
}