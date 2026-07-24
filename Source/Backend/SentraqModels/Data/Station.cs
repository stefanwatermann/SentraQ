using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("Station")]
public class Station
{
        [Key]
        public long Id { get; init; }
        
        [MaxLength(36)]
        public required string Uid { get; init; }
        
        [MaxLength(36)]
        public string? WatchdogHardwareId { get; set; }
    
        [MaxLength(250)]
        public required string DisplayName { get; set; }
    
        [MaxLength(50)]
        public required string ShortName { get; set; }
        
        public required decimal Latitude { get; set; }
        
        public required decimal Longitude { get; set; }
        
        [MaxLength(20)]
        public required string Type { get; set; }
        
        public string? DisplayColor { get; set; }
        
        public int? DisplayOrder { get; set; }
        
        public string? AlertReceiverEmailAddresses { get; set; }
        
        public bool Removed { get; set; }
        
        public bool Visible { get; set; }
        
        public DateTime? MaintenanceActiveSinceTs { get; set; }
        
        public DateTime? MaintenanceActiveAlertSentTs { get; set; }
        
        public ICollection<Component> Components { get; init; } = new List<Component>();
}