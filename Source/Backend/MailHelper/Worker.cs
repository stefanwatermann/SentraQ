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
        mailService.Send(settingService.AlertMailFrom, "SentraQ Test-Mail", "SentraQ Test-Mail");
        Console.WriteLine("Mail sent.");
        hostApplicationLifetime.StopApplication();
        return Task.CompletedTask;
    }
}