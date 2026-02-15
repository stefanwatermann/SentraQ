using Microsoft.Extensions.Logging;
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

public class ComponentService(
    ILogger<CacheService> logger,
    DatabaseContext dbContext)
{
    public Component? GetComponentByUid(string uid)
    {
        return dbContext
            .Components
            .FirstOrDefault(c => c.HardwareId == uid);
    }
}