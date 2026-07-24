using SentraqCommon.Context;

namespace SentraqCommon.Services;

public class AuthorizationService(
    DatabaseContext dbContext)
{
    public void ThrowWhenChangedByUserNotAdmin(string changedBy)
    {
        var user = dbContext
                       .Users
                       .SingleOrDefault(u => u.Login == changedBy && u.Role == "ADM") ??
                   throw new UnauthorizedAccessException(
                       $"ChangedBy user {changedBy} not found or does not have role ADM.");
    }
}