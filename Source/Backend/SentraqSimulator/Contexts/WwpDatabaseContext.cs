using Microsoft.EntityFrameworkCore;
using SentraqModels.Data;

namespace SentraqSimulator.Contexts;

public class WwpDatabaseContext(DbContextOptions<WwpDatabaseContext> options) : DbContext(options)
{
    public DbSet<EventData> EventData { get; init; }
    public DbSet<Station> Stations { get; init; }
    public DbSet<Component> Components { get; init; }
    public DbSet<ComponentView> ComponentViews { get; init; }
    public DbSet<Counter> Counters { get; init; }
}