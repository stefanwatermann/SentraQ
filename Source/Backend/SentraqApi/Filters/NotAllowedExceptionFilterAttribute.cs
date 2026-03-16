using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace SentraqApi.Filters;

public class NotAllowedExceptionFilterAttribute : ExceptionFilterAttribute
{
    public override void OnException(ExceptionContext context)
    {
        if (context.Exception is UnauthorizedAccessException)
        {
            var result = new ContentResult
            {
                Content = "User does not have required role to perform this action.",
                StatusCode = 551
            };
            context.Result = result;
        }
    }
}