using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class UserService(
    ILogger<CacheService> logger,
    LogService logService,
    DatabaseContext dbContext)
{
    public IQueryable<User> GetUsers()
    {
        return dbContext
            .Users;
    }

    public void LoggedOn(string login)
    {
        logService.AddInfo(LogService.Event.UserLogon, login);
        dbContext.SaveChanges();
    }

    /// <summary>
    /// Save the use to database.
    /// HINT: does not update the Hash value, since this can be update only by the PasswordRestService.
    /// </summary>
    /// <param name="user"></param>
    /// <param name="changedBy"></param>
    /// <exception cref="KeyNotFoundException"></exception>
    public void WriteUser(User user, string changedBy)
    {
        CheckChangedByUser(changedBy);

        var existingUser = dbContext
                               .Users
                               .SingleOrDefault(u => u.Login == user.Login);

        if (existingUser != null)
        {
            // update existing user
            existingUser.Login = user.Login;
            existingUser.Name = user.Name;
            existingUser.Email = user.Email;
            existingUser.Role = user.Role;
        }
        else
        {
            // add new user
            dbContext.Add(user);
        }

        logService.AddInfo(LogService.Event.UserChanged, $"User {user.Login} changed by {changedBy}.");
        dbContext.SaveChanges();
    }

    public void RemoveUser(string login, string changedBy)
    {
        CheckChangedByUser(changedBy);

        var user = dbContext
                       .Users
                       .SingleOrDefault(u => u.Login == login) ??
                   throw new KeyNotFoundException($"User {login} not found.");

        dbContext.Remove(user);
        logService.AddInfo(LogService.Event.UserRemoved, $"User {login} removed by {changedBy}.");
        dbContext.SaveChanges();
    }

    private void CheckChangedByUser(string changedBy)
    {
        var user = dbContext
                       .Users
                       .SingleOrDefault(u => u.Login == changedBy && u.Role == "ADM") ??
                   throw new UnauthorizedAccessException(
                       $"ChangedBy user {changedBy} not found or does not have role ADM.");
    }
}