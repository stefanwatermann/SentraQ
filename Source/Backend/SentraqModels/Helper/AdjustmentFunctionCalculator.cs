using System.Globalization;

namespace SentraqModels.Helper;

public static class AdjustmentFunctionCalculator
{
    /// <summary>
    /// Simple AdjustemtFunction.
    /// Field AdjustemtFunction of model can contain a math symbol (+-*/)
    /// and a number that will be applied to the payload. Payload is
    /// treated as double in this case.
    /// Example: "+10" adds 10 to the payload, "/10" divides payload by 10
    /// If no math symbol is provided "+" is the used as default.
    /// </summary>
    /// <returns>String containing the adjusted Payload value</returns>
    public static string Calc(string? adjustmentFunction, string? payload)
    {
        if (!string.IsNullOrWhiteSpace(adjustmentFunction) && !string.IsNullOrWhiteSpace(payload))
        {
            var v = double.Parse(payload);
            var func = char.IsNumber(adjustmentFunction[0]) ? '+' : adjustmentFunction[0];
            var adjust = Convert.ToDouble(char.IsNumber(adjustmentFunction[0])
                ? adjustmentFunction
                : adjustmentFunction[1..]);
            
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

        return payload ?? string.Empty;
    }

    public static string Calc(string? adjustmentFunction, object? payload)
    {
        return Calc(adjustmentFunction, payload?.ToString());
    }
}