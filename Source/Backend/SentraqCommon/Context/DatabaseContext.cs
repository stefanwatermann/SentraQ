using Microsoft.EntityFrameworkCore;
using SentraqModels.Data;

namespace SentraqCommon.Context;

public class DatabaseContext : DbContext
{
    public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
    {
        AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
        AppContext.SetSwitch("Npgsql.DisableDateTimeInfinityConversions", true);
    }

    public DbSet<EventData> EventData { get; init; }
    public DbSet<Station> Stations { get; init; }
    public DbSet<StationView> StationsView { get; init; }
    public DbSet<Component> Components { get; init; }
    public DbSet<ComponentView> ComponentsView { get; init; }
    public DbSet<Setting> Settings { get; init; }
    public DbSet<Alert> Alerts { get; init; }
    public DbSet<User> Users { get; init; }
    public DbSet<Log> Logs { get; init; }
    public DbSet<Counter> Counters { get; init; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        
    }
}