using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqCommon.Extensions;
using SentraqCommon.Services;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers.Management;

[ApiController]
[RequireAuthorizationKey]
[Route("api/management/user")]
public class MgmtUserController(
    ILogger<MgmtUserController> logger,
    UserService userService) : ControllerBase
{
    [HttpPost()]
    public void Write([FromBody] Api.User user, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        userService.WriteUser(UserMapper.Map(user), changedBy.Sanitize(10));
    }
    
    [HttpDelete("{userLogin}")]
    public void Remove(string userLogin, [FromHeader(Name = "X-LOGIN")] string changedBy)
    {
        userService.RemoveUser(userLogin.Sanitize(10), changedBy.Sanitize(10));
    }
}