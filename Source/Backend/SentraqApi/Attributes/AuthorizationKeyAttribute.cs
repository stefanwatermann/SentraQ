using Microsoft.AspNetCore.Mvc;
using SentraqApi.AuthFilter;

namespace SentraqApi.Attributes;

/// <summary>
/// Api requires authorization key header to be set.
/// </summary>
public class AuthorizationKeyAttribute() : 
    ServiceFilterAttribute(typeof(AuthorizationKeyAuthFilter));