using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class ComponentExtensions
{
    public static string ReplaceVars(this Component component, string template)
    {
        return template
            .Replace("{Component.HardwareId}", component.HardwareId)
            .Replace("{Component.DisplayName}", component.DisplayName)
            .Replace("{Component.ShortName}", component.ShortName);
    }
}