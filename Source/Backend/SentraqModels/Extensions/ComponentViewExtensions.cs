using SentraqModels.Data;
using SentraqModels.Helper;

namespace SentraqModels.Extensions;

public static class ComponentViewExtensions
{
    public static string? AdjustedPayload(this ComponentView cv)
    {
        return AdjustmentFunctionCalculator.Calc(cv.AdjustmentFunction, cv.LastPayload);
    }
}