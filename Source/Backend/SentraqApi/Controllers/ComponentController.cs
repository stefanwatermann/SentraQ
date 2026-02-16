using Microsoft.AspNetCore.Mvc;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqModels.Mapper;
using Api = SentraqModels.Api;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/components")]
public class ComponentController(
    DatabaseContext dbContext) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpGet("{componentUid}")]
    public Api.Component Get(string componentUid)
    {
        var componentView = dbContext
                .ComponentsView
                .FirstOrDefault(c => c.HardwareId == componentUid.Sanitize(36)) ??
            throw new KeyNotFoundException("Component not found");

        return ComponentMapper.Map(componentView);
    }
}