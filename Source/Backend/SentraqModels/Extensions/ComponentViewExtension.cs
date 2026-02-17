using System.Globalization;
using SentraqModels.Data;

namespace SentraqModels.Extensions;

public static class ComponentViewExtension
{
    /// <summary>
    /// Simple AdjustemtFunction.
    /// Field AdjustemtFunction of model can contain a math symbol (+-*/)
    /// and a number that will be applied to the payload. Payload is
    /// treated as double in this case.
    /// Example: "+10" adds 10 to the payload, "/10" divides payload by 10
    /// If no math symbol is provided "+" is the used as default.
    /// </summary>
    /// <param name="cv">ComponentView object</param>
    /// <returns>String containing the adjusted Payload value</returns>
    public static string? AdjustedPayload(this ComponentView cv)
    {
        if (!string.IsNullOrWhiteSpace(cv.AdjustmentFunction) && !string.IsNullOrWhiteSpace(cv.LastPayload))
        {
            var v = double.Parse(cv.LastPayload);
            var func = char.IsNumber(cv.AdjustmentFunction[0]) ? '+' : cv.AdjustmentFunction[0];
            var adjust = Convert.ToDouble(char.IsNumber(cv.AdjustmentFunction[0])
                ? cv.AdjustmentFunction
                : cv.AdjustmentFunction[1..]);
            
            switch (func)
            {
                case '+':
                    return (v + adjust).ToString(CultureInfo.InvariantCulture);
                case '-':
                    return (v - adjust).ToString(CultureInfo.InvariantCulture);
                case '*':
                    return (v * adjust).ToString(CultureInfo.InvariantCulture);
                case '/':
                    return (v / adjust).ToString(CultureInfo.InvariantCulture);
            }
        }

        return cv.LastPayload;
    }
}