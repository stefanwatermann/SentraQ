using Microsoft.AspNetCore.Mvc;
using SentraqApi.Filters;

namespace SentraqApi.Attributes;

/// <summary>
/// Api requires authorization key header to be set.
/// </summary>
public class RequireAuthorizationKeyAttribute() : 
    ServiceFilterAttribute(typeof(RequireAuthorizationKeyAuthFilter));