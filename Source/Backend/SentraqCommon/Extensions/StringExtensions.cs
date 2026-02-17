using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Web;

namespace SentraqCommon.Extensions;

public static class StringExtensions
{
    public static string[] SplitCamelCase(this string? source) 
    {
        if (string.IsNullOrEmpty(source))
            return new string[0];
        return Regex.Split(source, @"(?<!^)(?=[A-Z])");
    }

    /// <summary>
    /// Ensure that string does not contain malicious characters.
    /// </summary>
    /// <param name="s">un-sanitized string</param>
    /// <param name="maxLength">shorten string to given length</param>
    /// <returns>sanitized string</returns>
    public static string Sanitize(this string s, int maxLength)
    {
        if (string.IsNullOrEmpty(s))
            return "";
        if (maxLength > 0 && s.Length > maxLength)
            s = s[..maxLength];
        return HttpUtility.HtmlEncode(s.Replace(Environment.NewLine, ""));
    }
}