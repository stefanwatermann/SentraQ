// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using Microsoft.Extensions.Hosting;
using SentraqCommon.Services;

namespace MailHelper;

public sealed class Worker(
    IHostApplicationLifetime hostApplicationLifetime,
    SettingService settingService,
    MailService mailService) : BackgroundService
{
    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        mailService.SendAsync(settingService.AlertMailFrom, "SentraQ Test-Mail", "SentraQ Test-Mail");
        Console.WriteLine("Mail sent.");
        hostApplicationLifetime.StopApplication();
        return Task.CompletedTask;
    }
}