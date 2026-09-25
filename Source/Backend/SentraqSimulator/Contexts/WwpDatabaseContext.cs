using Microsoft.EntityFrameworkCore;
using SentraqModels.Data;
using SentraqModels.Enums;

namespace SentraqSimulator.Contexts;

public class WwpDatabaseContext(DbContextOptions<WwpDatabaseContext> options) : DbContext(options)
{
    public DbSet<EventData> EventData { get; init; }
    public DbSet<Station> Stations { get; init; }
    public DbSet<Component> Components { get; init; }
    public DbSet<ComponentView> ComponentViews { get; init; }
    public DbSet<Counter> Counters { get; init; }
    
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