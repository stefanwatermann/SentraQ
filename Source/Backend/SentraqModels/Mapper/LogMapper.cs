namespace SentraqModels.Mapper;

public static class LogMapper
{
    public static Api.Log Map(Data.Log log)
    {
        return new Api.Log()
        {
            Severity = log.Severity,
            EventType = log.Event,
            LogTs = log.LogTs,
            Message = log.Message
        };
    }
}