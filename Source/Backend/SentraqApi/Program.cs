// #######################################################################################
// Sentraq Backend - Frontend-API
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Reflection;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.EntityFrameworkCore;
using SentraqApi.AuthFilter;
using SentraqCommon.Context;
using SentraqCommon.Converters;
using SentraqCommon.Security;
using SentraqCommon.Services;

[assembly: AssemblyVersion("1.0.0.*")]

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers().AddJsonOptions(options =>
{
    // render json properties with uppercase first letter, important for the XOJO frontend
    options.JsonSerializerOptions.PropertyNamingPolicy = null;
    // datetime serialization
    options.JsonSerializerOptions.Converters.Add(new SimpleDateTimeConverter());
});

var connStr = builder.Configuration.GetConnectionString("DbConnection") ?? 
              throw new InvalidOperationException("Could not find connection string in appsettings.json");

builder.Services.AddDbContext<DatabaseContext>(options =>
    options.UseNpgsql(Decrypt.PasswordInConnectionString(connStr, Secrets.EncryptionPwd)));

builder.Services.AddScoped<SettingService>();
builder.Services.AddScoped<CacheService>();
builder.Services.AddScoped<StationService>();
builder.Services.AddScoped<ComponentService>();
builder.Services.AddScoped<MailService>();
builder.Services.AddScoped<PasswordResetService>();
builder.Services.AddScoped<LogService>();
builder.Services.AddScoped<StatusFileService>();
builder.Services.AddScoped<AuthorizationKeyAuthFilter>();

builder.Services.AddLogging(b =>
{
    b.ClearProviders();
    b.AddConfiguration(builder.Configuration.GetSection("Logging"))
        .AddConsole()
        .AddDebug();
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

// configure globale exception handler for un-caught exceptions
app.UseExceptionHandler(options =>
{
    options.Run(async context =>
    {
        context.Response.StatusCode = StatusCodes.Status500InternalServerError;
        context.Response.ContentType = "application/json";
        
        var exceptionFeature = context.Features.Get<IExceptionHandlerFeature>();
        if (exceptionFeature is not null)
        {
            // return generic message and log detailed message
            var genericMessage = new { message = $"An unexpected error occurred" };
            var detailedMessage = $"path={exceptionFeature.Path}, error={exceptionFeature.Error.Message}";
            app.Logger.LogError(detailedMessage);
            await context.Response.WriteAsJsonAsync(genericMessage);
        }
    });
});

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();