// #######################################################################################
// Sentraq Plattform
// Copyright (c) 2026, Stefan Watermann, Watermann IT, Germany (www.watermann-it.de)
// Licensed under the GPL 3.0 license. See LICENSE file in the project root for details.
// #######################################################################################
namespace SentraqSimulator.Interfaces;

public interface ISimulator
{
    void Init(int simulationDelayMSec);
    void StartSimulation();
}