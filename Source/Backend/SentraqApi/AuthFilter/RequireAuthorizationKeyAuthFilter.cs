using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using SentraqCommon.Services;

namespace SentraqApi.AuthFilter;

/// <summary>
/// Checks that api-request provides the required authorization key header.
/// </summary>
public class RequireAuthorizationKeyAuthFilter(
    SettingService settings
    ) : IAuthorizationFilter
{
    private const string _requestAuthKeyHeaderName = "X-AUTH-KEY";
    private const string _requiredAuthKeyConfigurationKey = "RequiredAuthKey";
    
    public void OnAuthorization(AuthorizationFilterContext context)
    {
        var requiredAuthKeyValue = settings.ApiRequiredAuthKey;
        var requestAuthKeyValue = context.HttpContext.Request.Headers[_requestAuthKeyHeaderName].ToString();
        
        if (string.IsNullOrWhiteSpace(requestAuthKeyValue))
        {
            context.Result = new BadRequestResult();
            return;
        }
        
        if (!requestAuthKeyValue.Equals(requiredAuthKeyValue))
            context.Result = new UnauthorizedResult();
    }
}