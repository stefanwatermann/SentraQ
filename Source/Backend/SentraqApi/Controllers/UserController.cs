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
    PasswordService passwordService,
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
    [NotAllowedExceptionFilter]
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
        userService.RemoveUser(userLogin.Sanitize(10), changedBy.Sanitize(10));
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
        passwordService.RequestPasswordReset(login.Sanitize(10));
    }
    
    [RequireAuthorizationKey]
    [HttpPost("setNewPassword/{login}")]
    public void SetNewPassword(string login, [FromBody] JsonObject data)
    {
        var newPwdHash = data.FirstOrDefault(j => j.Key == "newPwdHash").Value;

        if (newPwdHash == null)
            throw new KeyNotFoundException($"Key {nameof(newPwdHash)} not found in JSON data.");
        
        passwordService.SetNewPassword(login.Sanitize(10), newPwdHash.ToString());
    }
    
    [RequireAuthorizationKey]
    [HttpGet("byResetCode/{resetCode}")]
    public Api.User UserByPasswordReset(string resetCode)
    {
        return UserMapper.Map(passwordService.GetUserByPasswordResetCode(resetCode));
    }
    
    [RequireAuthorizationKey]
    [HttpPost("requestPasskey/{login}")]
    public void RequestPasskey(string login)
    {
        passwordService.RequestPasskey(login.Sanitize(10));
    }
    
    [RequireAuthorizationKey]
    [HttpGet("byPasskeyRequestCode/{resetCode}")]
    public Api.User UserByPasskeyResetCode(string resetCode)
    {
        return UserMapper.Map(passwordService.GetUserByPasskeyRequestCode(resetCode));
    }
    
    [RequireAuthorizationKey]
    [HttpPost("setNewPasskey/{login}")]
    public void SetNewPasskey(string login, [FromBody] JsonObject data)
    {
        var newPasskeyHash = data.FirstOrDefault(j => j.Key == "newPasskeyHash").Value;

        if (newPasskeyHash == null)
            throw new KeyNotFoundException($"Key {nameof(newPasskeyHash)} not found in JSON data.");
        
        passwordService.SetNewPasskey(login.Sanitize(10), newPasskeyHash.ToString().Sanitize(1000));
    }
}