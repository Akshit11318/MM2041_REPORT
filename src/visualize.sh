#!/bin/bash
# Script for visualizing Saffman-Taylor instability simulation in ParaView on Ubuntu

# Create the .foam file needed for ParaView
rm -f openfoam-simulation.OpenFOAM
touch openfoam-simulation.foam

# Start ParaView with the case file
echo "Starting ParaView for OpenFOAM visualization..."
echo "If ParaView doesn't start automatically, run: paraview openfoam-simulation.foam"

# Launch ParaView
paraview openfoam-simulation.foam &