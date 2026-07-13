namespace SentraqCommon.Exceptions;

public class MissingRequiredSettingException(string[] message) : Exception
{
    public override string Message { get; } = 
        $"One or more required Settings cannot be found or does not have a value. Please add values to: {string.Join(", ", message)}.";
}