# Makefile for Saffman-Taylor viscous fingering OpenFOAM simulation (Linux only)
# Created: April 26, 2025

# Variables
CASE_DIR := $(shell pwd)
NCORES ?= 4  # Default to 4 cores, can override with make NCORES=8

.PHONY: all clean mesh initialize decompose run reconstruct visualize

all: mesh initialize run

# Generate the mesh
mesh:
	@echo "Generating mesh..."
	blockMesh

# Initialize the fields with setFields
initialize:
	@echo "Initializing fields..."
	setFields

# Decompose the domain for parallel execution
decompose:
	@echo "Decomposing domain for $(NCORES) cores..."
	decomposePar

# Run the simulation in parallel
run: decompose
	@echo "Running interFoam solver on $(NCORES) cores..."
	mpirun -np $(NCORES) interFoam -parallel > log.interFoam

# Reconstruct case from parallel run
reconstruct:
	@echo "Reconstructing case from parallel run..."
	reconstructPar

# Visualize results with ParaView
visualize:
	@echo "Preparing visualization..."
	bash src/visualize.sh

# Clean the case (remove time directories except 0)
clean:
	@echo "Cleaning time directories (keeping 0/)..."
	@find . -maxdepth 1 -type d -name "[1-9]*" -o -name "[1-9]*.[0-9]*" | xargs -r rm -rf
	@rm -f log.*

# Deep clean (remove all generated files including mesh and decomposition)
clean-all: clean
	@echo "Removing processor directories..."
	@rm -rf processor*
	@echo "Removing visualization files..."
	@rm -f *.foam openfoam-simulation.OpenFOAM

# Monitor progress
monitor:
	@echo "Monitoring simulation progress..."
	@tail -f log.interFoam

# Help target
help:
	@echo "Available targets:"
	@echo "  all               - Run the full simulation (mesh, initialize, run)"
	@echo "  mesh              - Generate the mesh using blockMesh"
	@echo "  initialize        - Initialize the fields using setFields"
	@echo "  decompose         - Decompose the domain for parallel execution"
	@echo "  run               - Run the simulation in parallel"
	@echo "  reconstruct       - Reconstruct the case from parallel run"
	@echo "  visualize         - Visualize the results using ParaView"
	@echo "  clean             - Remove time directories except 0/"
	@echo "  clean-all         - Remove all generated files"
	@echo "  monitor           - Monitor the simulation progress"
	@echo ""
	@echo "You can specify the number of cores with NCORES=X, e.g.:"
	@echo "  make run NCORES=8"