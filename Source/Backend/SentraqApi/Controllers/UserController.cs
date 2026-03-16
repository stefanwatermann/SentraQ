using System.Text.Json.Nodes;
using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqApi.Filters;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/user")]
public class UserController(
    ILogger<UserController> logger,
    PasswordResetService passwordResetService,
    UserService userService) : ControllerBase
{
    /// <summary>
    /// Returns a list of all users.
    /// </summary>
    /// <returns>List of stations</returns>
    [RequireAuthorizationKey]
    [HttpGet("")]
    public IEnumerable<Api.User?> Get()
    {
        return userService.GetUsers()
            .Select(u => UserMapper.Map(u))
            .ToList();
    }
    
    [RequireAuthorizationKey]
    [HttpPost()]
    public void Write([FromBody] Api.User user, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
       userService.WriteUser(UserMapper.Map(user), changedBy.Sanitize(10));
    }
    
    [RequireAuthorizationKey]
    [NotAllowedExceptionFilter]
    [HttpDelete("{userLogin}")]
    public void Remove(string userLogin, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        userService.RemoveUser(userLogin, changedBy.Sanitize(10));
    }

    [RequireAuthorizationKey]
    [HttpPost("loggedOn/{login}")]
    public void LoggedOn(string login)
    {
        userService.LoggedOn(login.Sanitize(10));
    }

    [RequireAuthorizationKey]
    [HttpPost("requestPasswordReset/{login}")]
    public void RequestPasswordReset(string login)
    {
        passwordResetService.RequestPasswordReset(login.Sanitize(10));
    }
    
    [RequireAuthorizationKey]
    [HttpPost("setNewPassword/{login}")]
    public void PasswordReset(string login, [FromBody] JsonObject data)
    {
        var newPwdHash = data.FirstOrDefault(j => j.Key == "newPwdHash").Value;

        if (newPwdHash == null)
            throw new KeyNotFoundException($"Key {nameof(newPwdHash)} not found in JSON data.");
        
        passwordResetService.SetNewPassword(login.Sanitize(10), newPwdHash.ToString());
    }
    
    [RequireAuthorizationKey]
    [HttpGet("byResetCode/{resetCode}")]
    public Api.User PasswordReset(string resetCode)
    {
        return UserMapper.Map(passwordResetService.GetUserByPasswordResetCode(resetCode));
    }
}