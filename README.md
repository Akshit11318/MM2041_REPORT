# MM2041 - REPORT ON THE SAFFMAN-TAYLOR INSTABILITY
> Akshit Vakati Venkata 
## Saffman-Taylor Viscous Fingering Simulation
## OpenFOAM Case for Linear Geometry

This OpenFOAM case simulates the Saffman-Taylor instability (viscous fingering phenomenon) that occurs when a less viscous fluid (water) displaces a more viscous fluid (oil) in a horizontal Hele-Shaw cell-like geometry.

## Problem Description

- Domain: 10m × 2.5m × 0.01m thin horizontal cell
- Initially filled with oil (more viscous fluid)
- Water (less viscous fluid) injected at the inlet
- Mobility ratio (μoil/μwater) = 100, favorable for fingering
- No gravity effects (horizontal displacement)
- Surface tension coefficient = 0.02 N/m
- Simulation time: 800 seconds (extended from initial 400 seconds)

## Prerequisites

- OpenFOAM v2212 or compatible version
- Basic knowledge of OpenFOAM case structure and commands
- Sufficient computational resources for parallel computing (14 cores recommended)
- For the report, a LaTeX distribution (e.g., TeX Live or MikTeX)

## Project Structure

```
linear-openfoam/
├── 0/                  # Initial conditions
│   ├── alpha.water     # Water volume fraction
│   ├── p               # Pressure
│   ├── p_rgh           # Dynamic pressure
│   └── U               # Velocity
├── constant/           # Physical properties
│   ├── g               # Gravity
│   ├── transportProperties # Material properties
│   └── turbulenceProperties # Turbulence model settings
├── system/             # Numerical settings
│   ├── blockMeshDict   # Mesh generation
│   ├── controlDict     # Simulation control
│   ├── decomposeParDict # Domain decomposition
│   ├── fvSchemes       # Discretization schemes
│   ├── fvSolution      # Linear solver settings
│   └── setFieldsDict   # Initial field setup
├── src/                # Source scripts
│   └── visualize.sh    # Script for ParaView visualization
├── simulation/         # Simulation results and analysis
│   └── *.png           # Exported visualization frames
├── simulation.mp4      # Rendered video of the simulation
├── report/             # Report files
│   ├── latex/          # LaTeX source files for the report
│   ├── output/         # Compiled report output (PDF)
│   └── Makefile        # Makefile for building the report
└── Makefile            # Main Makefile for running simulations
```

## Current Simulation Configuration

The latest simulation settings include:
- Extended simulation time up to 800 seconds
- Smaller initial time step (deltaT = 0.004) for improved stability
- Conservative Courant number (maxCo = 0.25) for better stability
- Write interval of 5 seconds for optimized data sampling
- Simulation data stored in time directories from 0 to 800 seconds
- Mesh resolution of 500 × 125 × 1 cells for the 10m × 2.5m × 0.01m domain
- Probes placed at strategic positions to monitor:
  - Center of the domain (5.0, 1.25, 0.005)
  - Quarter-way through domain (2.5, 1.25, 0.005)
  - Three-quarters through domain (7.5, 1.25, 0.005)

## Using the Makefiles

### Simulation

The main Makefile provides several targets to help with the simulation:

```bash
# View available targets and help
make help

# Run the complete simulation (mesh, initialize, run)
make all

# Generate the mesh only
make mesh

# Initialize the fields
make initialize

# Run the simulation with a specific number of cores
make run NCORES=8

# Apply natural perturbation
make natural-perturbation

# Apply center release pattern
make center-release

# Reconstruct case from parallel run
make reconstruct

# Visualize results with ParaView
make visualize

# Clean up temporary files
make clean

# Deep clean (remove all generated files)
make clean-all
```

### LaTeX Report

A separate Makefile is provided for building the report:

```bash
# Change to the report directory
cd report

# View available targets and help
make help

# Compile the LaTeX report
make

# Open the PDF with the default viewer
make view

# Clean temporary files but keep the PDF
make clean-temp

# Remove all generated files including the PDF
make clean
```

## Performance Considerations

- The simulation uses adaptive time stepping with a maximum Courant number of 0.5
- With 14 cores, expect the simulation to complete in approximately 1-2 hours
- Monitor the Courant number in the log file to ensure stability
- If the simulation is too slow, consider increasing maxCo (but watch for instabilities)

## Troubleshooting

- **Parallel run crashes**: Check the processor* directories for any inconsistent fields
- **Courant number too high**: Reduce maxCo in controlDict
- **Convergence issues**: Check the residuals and consider adjusting solver tolerances in fvSolution
- **Load imbalance**: Try different decomposition methods in decomposeParDict

## Visualization Tips

For better visualization of the viscous fingering:
- Use contour plots of alpha.water at values around 0.5 to see the interface
- Vector plots of velocity can show flow patterns around fingers
- Use a slice filter in ParaView to view the mid-plane
- Adjust the color map to highlight the fingering patterns
- Save screenshots at various time steps for analysis
- Consider using the "Stream Tracer" filter in ParaView to visualize flow lines
- Use the "Clip" filter to slice through the domain and visualize internal structures
- Experiment with different rendering options (e.g., "Surface with Edges") to enhance visibility
- Use the "Animation View" in ParaView to create a time-lapse of the fingering development
- Save the ParaView state file to easily reproduce visualizations later
- Consider using the "Threshold" filter to isolate specific regions of interest (e.g., high alpha.water values)
- Use the "Calculator" filter to create new fields based on existing ones (e.g., velocity magnitude)
- Explore the "Plot Over Line" filter to analyze velocity profiles along specific lines in the domain
- Use the "Slice" filter to create cross-sectional views of the domain