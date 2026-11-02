// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Data;

namespace SentraqModels.Extensions;

public static class DataTableExtensions
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