using System.Data;
using Microsoft.AspNetCore.Mvc;
using Npgsql;
using SentraqApi.Attributes;
using SentraqCommon.Context;
using SentraqCommon.Extensions;
using SentraqCommon.Security;
using SentraqModels.Extensions;

namespace SentraqApi.Controllers;

[ApiController]
[Route("api/table")]
public class TableController(
    IConfiguration configuration,
    DatabaseContext dbContext) : ControllerBase
{
    [RequireAuthorizationKey]
    [HttpPost("{tableName}")]
    public object? Post(string tableName, [FromBody] string whereCondition, [FromQuery] bool desc = false, [FromQuery] string orderBy = "", [FromQuery] int limit = 10)
    {
        if (string.IsNullOrWhiteSpace(tableName.Sanitize(50)))
            return null;
        
        if (string.IsNullOrWhiteSpace(orderBy))
            orderBy = "Id";
        
        var tn = tableName.Sanitize(50);
        var ob = orderBy.Sanitize(200);
        var where = whereCondition.Replace("--", "").Replace("''", "").MaxLength(1000);
        
        ob = "\"" + ob + "\"";
        
        if (desc)
            ob += " desc";

        var connStr = configuration.GetConnectionString("DbConnection")  ??
                      throw new InvalidOperationException("Could not find connection string in appsettings.json");
        
        var sql = $"SELECT * FROM \"{tn}\" {where} ORDER BY {ob} LIMIT {limit}";
        
        var dt = new DataTable(tn);
        var da = new NpgsqlDataAdapter(sql, Decrypt.PasswordInConnectionString(connStr, Secrets.EncryptionPwd));
        da.Fill(dt);
        
        return dt.AsCsv("~");
    }
}