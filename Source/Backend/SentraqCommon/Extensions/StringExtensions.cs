using System.Text.RegularExpressions;

namespace SentraqCommon.Extensions;

public static class StringExtensions
{
    public static string[] SplitCamelCase(this string? source) {
        if (string.IsNullOrEmpty(source))
            return new string[0];
        return Regex.Split(source, @"(?<!^)(?=[A-Z])");
    }
}