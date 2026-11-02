// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
using System.Runtime.CompilerServices;
using Microsoft.EntityFrameworkCore;
using SentraqCommon.Context;
using SentraqModels.Data;

namespace SentraqCommon.Services;

/// <summary>
/// Manage access to the aggregation views.
/// </summary>
/// <param name="dbContext"></param>
public class AggregationService(
    DatabaseContext dbContext)
{
    /// <summary>
    /// Return data from one of the aggregation views (e.g. vAggregationSum1h).
    /// </summary>
    /// <param name="postfix">Postfix of an aggregation-view name (e.g. Sum1h), case-sensitive!</param>
    /// <param name="hwId">HardwareId of the component to aggregate over</param>
    /// <param name="take">Number of records to return</param>
    /// <returns></returns>
    public IEnumerable<Aggregation> Get(string postfix, string hwId, int take)
    {
        var sql = $"SELECT * FROM public.\"vAggregation{postfix}\" WHERE \"HardwareId\" = '{hwId}'";
        
        var agg = dbContext
            .Aggregations
            .FromSql<Aggregation>(FormattableStringFactory.Create(sql))
            .AsNoTracking()
            .OrderByDescending(a => a.DateBin)
            .Take(take)
            .ToList();

        return agg;
    }
}