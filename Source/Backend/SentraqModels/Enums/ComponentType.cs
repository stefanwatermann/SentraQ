namespace SentraqModels.Enums;

/// <summary>
/// Komponenten Typen.
/// WICHTIG: muss mit den UI ComponentTypes und dem Check-Constraint der Tabelle Component übereinstimmen!
/// </summary>
public enum ComponentType
{
    // Unbekannte Komponente
    Undefined = 0,
    
    // Schalter oder ähnliches
    Actor = 1,
    
    // Zähler Zeitdifferenz, z.B. Betriebsstunden
    CounterTimeDiff = 2,
    
    // Liefert einen Messwert
    Sensor = 3,
    
    // Füllstand
    FillLevel = 4,
    
    // Fehler, führt zu einem Alert auf Stationsebene
    Fault = 5,
    
    // Hilfskomponente um Komponenten im UI zu gruppieren
    Divider = 6,
    
    // Schaltbarer Aktor
    Switch = 7,
    
    // Zähler Aufsummierung, z.B. Mengen
    CounterValueAdd = 8
}

public static class ComponentTypeExtensions
{
    public static ComponentType FromString(this string t)
    {
        return t switch
        {
            "FI" => ComponentType.FillLevel,
            "FL" => ComponentType.Fault,
            "AC" => ComponentType.Actor,
            "SW" => ComponentType.Switch,
            "CO" => ComponentType.CounterTimeDiff,
            "CV" => ComponentType.CounterValueAdd,
            "SE" => ComponentType.Sensor,
            "DI" => ComponentType.Divider,
            _ => ComponentType.Undefined
        };
    }
}