using Microsoft.Extensions.Configuration;
using MimeKit;
using SentraqCommon.Security;
using SentraqModels.Data;
using SentraqModels.Extensions;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace SentraqCommon.Services;

public class MailService(
    IConfiguration config,
    SettingService settings)
{
    public async Task SendAsync(string to, string subject, string htmlBody)
    {
        // do not send e-mails to real users if running as test-system, use value of TestSystem:MailReceiver instead.
        if (!string.IsNullOrWhiteSpace(config["IsTestSystem:OverwriteMailTo"]))
            to = config["IsTestSystem:OverwriteMailTo"] ?? string.Empty;
        
        var message = new MimeMessage();
        message.Subject = subject;
        message.Importance = MessageImportance.High;
        message.From.Add(new MailboxAddress(settings.AlertMailFrom, settings.AlertMailFrom));
        
        foreach (var adr in to.Split(';'))
            message.To.Add(new MailboxAddress(adr.Trim(), adr.Trim()));
        
        message.Body = new TextPart("html")
        {
            Text = htmlBody
        };

        using var client = new SmtpClient();
        client.ServerCertificateValidationCallback = (s, c, h, e) => true;
        await client.ConnectAsync(settings.MailServerName, settings.MailServerPort, true);
        await client.AuthenticateAsync(settings.MailServerUser, Decrypt.Text(settings.MailServerPassword, Secrets.EncryptionPwd));
        await client.SendAsync(message);
        await client.DisconnectAsync(true);
    }

    public async void SendMaintenanceActiveMessage(Station station)
    {
        if (!station.MaintenanceActiveSinceTs.HasValue ||
            string.IsNullOrWhiteSpace(station.AlertReceiverEmailAddresses)) 
            throw new Exception("Try to send maintenance active message, but MaintenanceActiveSinceTs is not set or AlertReceiverEmailAddresses is empty.");
        
        var totalMaintenanceHours = DateTime.Now.Subtract(station.MaintenanceActiveSinceTs.Value).TotalHours;
        var subject = station.ReplaceVars(settings.MaintenanceActiveMailAlertSubject);
        var htmlBody = station
            .ReplaceVars(settings.MaintenanceActiveMailAlertMessage)
            .Replace("{Maintenance.Hours}", $"{totalMaintenanceHours:F0}");
            
        await SendAsync(station.AlertReceiverEmailAddresses, subject, htmlBody);
    }
}