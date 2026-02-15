using System.ComponentModel.DataAnnotations.Schema;

namespace SentraqModels.Data;

[Table("vStation")]
public class StationView : Station
{
    public bool HasActiveAlert { get; init; }
}