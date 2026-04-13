using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class UserService(
    ILogger<CacheService> logger,
    LogService logService,
    AuthorizationService authorizationService,
    DatabaseContext dbContext)
{
    public IQueryable<User> GetUsers()
    {
        return dbContext
            .Users
            .Where(u => !u.Removed);
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
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

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
            existingUser.Removed = false;
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
        authorizationService.ThrowWhenChangedByUserNotAdmin(changedBy);

        var user = dbContext
                       .Users
                       .SingleOrDefault(u => u.Login == login) ??
                   throw new KeyNotFoundException($"User {login} not found.");

        user.Removed = true;
        
        logService.AddInfo(LogService.Event.UserRemoved, $"User {login} (id={user.Id}) removed by {changedBy}.");
        dbContext.SaveChanges();
    }
}