using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqCommon.Exceptions;
using Data = SentraqModels.Data;

namespace SentraqCommon.Services;

public class PasswordResetService(
        ILogger<CacheService> logger,
        DatabaseContext dbContext,
        LogService logService,
        MailService mailService,
        SettingService settings)
{
    public void RequestPasswordReset(string login)
    {
        var user = GetUserByLogin(login);
        
        var resetCode = CreateResetCode();
        var resetLink = settings.PasswordResetFrontendUrl.Replace("{resetCode}", resetCode[8..]);
        
        var body = settings.PasswordResetMailBody
            .Replace("{PasswordResetLink}", resetLink)
            .Replace("{PasswordResetCode}", $"{resetCode[..4]}-{resetCode[4..8]}")
            .Replace("{PasswordResetCodeLifetimeMinutes}", Convert.ToString(settings.PasswordResetCodeLifetimeMinutes));
        
        mailService.Send(user.Email, settings.PasswordResetMailSubject, body);

        user.PasswordResetCode = resetCode;
        user.PasswordResetTs = DateTime.Now;
        
        logService.Add(LogService.Event.UserPasswordResetRequested);

        dbContext.SaveChanges();
    }

    public void SetNewPassword(string login, string pwdHash)
    {
        var user = GetUserByLogin(login);

        user.PasswordResetTs = null;
        user.PasswordResetCode = null;
        user.Hash = pwdHash;
        
        logService.Add(LogService.Event.UserPasswordChanged);

        dbContext.SaveChanges();
        
        logger.LogInformation("Passwort geändert für Login {login}", login);
    }

    public Data.User GetUserByPasswordResetCode(string code)
    {
        if (string.IsNullOrWhiteSpace(code))
            throw new ArgumentNullException(nameof(code));
        
        var user = dbContext
            .Users
            .FirstOrDefault(u => u.PasswordResetCode == code);
        
        if (user == null)
            throw new KeyNotFoundException("User '{code}' not found");
        
        if (string.IsNullOrWhiteSpace(user.PasswordResetCode) || 
            user.PasswordResetTs < DateTime.Now.AddMinutes(-settings.PasswordResetCodeLifetimeMinutes) ||
            user.PasswordResetCode != code)
            throw new PasswordResetCodeInvalidOrExpiredException();
        
        return user;
    }

    private Data.User GetUserByLogin(string login)
    {
        if (string.IsNullOrWhiteSpace(login))
            throw new ArgumentNullException(nameof(login));
        
        var user = dbContext
            .Users
            .FirstOrDefault(u => u.Login == login);
        
        if (user == null)
            throw new KeyNotFoundException("Login '{code}' not found");
        
        return user;
    }
    private string CreateResetCode()
    {
        var b = Encoding.Default.GetBytes(settings.PasswordResetCodeSalt + DateTime.Now.ToString("yyyyMMddHHmmssfff"));
        var c = Convert.ToHexString(MD5.HashData(b));
        return c;
    }
}