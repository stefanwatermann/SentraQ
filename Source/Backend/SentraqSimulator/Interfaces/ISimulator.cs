namespace SentraqSimulator.Services;

public interface ISimulator
{
    void Init(int simulationDelayMSec);
    void StartSimulation();
}