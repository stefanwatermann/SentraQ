namespace SentraqCommon.Exceptions;

public class PasswordResetCodeInvalidOrExpiredException() :
    Exception("Der Passwort-Code ist ungültig oder abgelaufen.")
{
}