// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using Microsoft.Extensions.Logging;

namespace SentraqCommon.Loggers;

/// <summary>
/// Specialized logger implementation to log error messages
/// (log-level error or critical) to a local error-file.
/// </summary>
/// <param name="category"></param>
/// <param name="logfileName"></param>
public class ExceptionFileLogger(
    string category, 
    string logfileName) : ILogger
{
    public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception? exception,
        Func<TState, Exception?, string> formatter)
    {
        if (!IsEnabled(logLevel))
            return;
        
        var message = formatter(state, exception).Replace('\n', ' ').Replace('\r', ' ');

        try
        {
            var log = $"{logLevel.ToString().ToUpper()}; {DateTime.Now:yyyy-MM-dd HH:mm:ss}; {category.ToUpper()}; {message}{Environment.NewLine}";
            File.AppendAllText(logfileName, log);
        }
        catch (Exception e)
        {
            Console.WriteLine($"FALLBACK: cannot write to {logfileName}: {e.Message}, log-message was: {message}");
        }
    }

    public bool IsEnabled(LogLevel logLevel)
    {
        return logLevel is LogLevel.Error or LogLevel.Critical;
    }

    public IDisposable? BeginScope<TState>(TState state) where TState : notnull
    {
        return null;
    }
}

public class ExceptionFileLoggerProvider(string logfileName) : ILoggerProvider
{
    public ILogger CreateLogger(string categoryName)
    {
        return new ExceptionFileLogger(categoryName, logfileName);
    }

    public void Dispose()
    {
    }
}