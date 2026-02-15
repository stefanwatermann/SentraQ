namespace SentraqModels.Mapper;

public static class UserMapper
{
    public static Api.User Map(Data.User user)
    {
        return new Api.User()
        {
            Login = user.Login,
            Name = user.Name,
            Hash = user.Hash,
            Role = user.Role,
            Email = user.Email
        };
    }
}