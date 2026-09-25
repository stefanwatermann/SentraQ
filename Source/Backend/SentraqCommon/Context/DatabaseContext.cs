using Microsoft.EntityFrameworkCore;
using SentraqModels.Data;
using SentraqModels.Enums;

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
    public DbSet<AlertView> AlertsView { get; init; }
    public DbSet<User> Users { get; init; }
    public DbSet<Log> Logs { get; init; }
    public DbSet<Counter> Counters { get; init; }
    public DbSet<Aggregation> Aggregations { get; init; }
    public DbSet<EventDataExport> EventDataExports { get; init; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Station>()
            .Property(e => e.StationControllerType)
            .HasConversion(
                c => c.ToString(),
                c => (StationControllerType)Enum.Parse(typeof(StationControllerType), c)
                );
        
        modelBuilder.Entity<Counter>()
            .Property(e => e.Type)
            .HasConversion(
                c => c.ToString(),
                c => (CounterType)Enum.Parse(typeof(CounterType), c)
            );
    }
}