using System.Net.Mail;
using MimeKit;
using SentraqCommon.Security;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace SentraqCommon.Services;

public class MailService(
    SettingService settings)
{
    public void Send(string to, string subject, string htmlBody)
    {
        var message = new MimeMessage();
        message.From.Add(new MailboxAddress(settings.AlertMailFrom, settings.AlertMailFrom));
        foreach (var adr in to.Split(';'))
            message.To.Add(new MailboxAddress(adr.Trim(), adr.Trim()));
        message.Subject = subject;
        message.Importance = MessageImportance.High;
        message.Body = new TextPart("html")
        {
            Text = htmlBody
        };

        using var client = new SmtpClient();
        client.ServerCertificateValidationCallback = (s, c, h, e) => true;
        client.Connect(settings.MailServerName, settings.MailServerPort, true);
        client.Authenticate(settings.MailServerUser, Decrypt.Text(settings.MailServerPassword, Secrets.EncryptionPwd));
        client.Send(message);
        client.Disconnect(true);
    }
}