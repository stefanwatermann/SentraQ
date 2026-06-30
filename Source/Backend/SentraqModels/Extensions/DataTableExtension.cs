using System.Data;

namespace SentraqModels.Extensions;

public static class DataTableExtension
{
    public static string[] AsCsv(this DataTable dt, string fieldSeparator = ";")
    {
        var lines = new List<string>();
        
        var cols = (from DataColumn column in dt.Columns select column.ColumnName).ToList();
        lines.Add(string.Join(fieldSeparator, cols));

        lines.AddRange(from DataRow row in dt.Rows select string.Join(fieldSeparator, row.ItemArray));

        return lines.ToArray();
    }
}