namespace SentraqCommon.Exceptions;

public class PasskeyRequestCodeInvalidOrExpiredException() :
    Exception("Der Passkey-Code ist ungültig oder abgelaufen.")
{
}