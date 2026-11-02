// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
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
            Email = user.Email,
            PasskeyIdent = user.PasskeyIdent ?? string.Empty,
        };
    }

    public static Data.User Map(Api.User user)
    {
        return new Data.User()
        {
            Login = user.Login,
            Name = user.Name,
            Email = user.Email,
            Hash = user.Hash,
            Role = user.Role,
            PasskeyIdent = user.PasskeyIdent
        };
    }
}