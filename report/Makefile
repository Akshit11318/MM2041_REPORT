# Makefile for LaTeX report compilation (Linux only)
# Created: April 26, 2025

# Variables
LATEX = pdflatex
BIBTEX = bibtex
SOURCE_DIR = ./latex
OUTPUT_DIR = ./output
MAIN = main
PDF = $(MAIN).pdf

# Create output directory if it doesn't exist
$(shell mkdir -p $(OUTPUT_DIR))

.PHONY: all clean view

# Default target
all: $(OUTPUT_DIR)/$(PDF)

# Rule to build the PDF
$(OUTPUT_DIR)/$(PDF): $(SOURCE_DIR)/$(MAIN).tex
	@echo "Compiling LaTeX document..."
	cd $(SOURCE_DIR) && \
	$(LATEX) -output-directory=../$(OUTPUT_DIR) $(MAIN) && \
	$(BIBTEX) ../$(OUTPUT_DIR)/$(MAIN) || true && \
	$(LATEX) -output-directory=../$(OUTPUT_DIR) $(MAIN) && \
	$(LATEX) -output-directory=../$(OUTPUT_DIR) $(MAIN)
	@echo "PDF generated at $(OUTPUT_DIR)/$(PDF)"

# Clean temporary files but keep the PDF
clean-temp:
	@echo "Cleaning temporary files..."
	rm -f $(OUTPUT_DIR)/*.aux $(OUTPUT_DIR)/*.log $(OUTPUT_DIR)/*.out $(OUTPUT_DIR)/*.toc \
		$(OUTPUT_DIR)/*.lof $(OUTPUT_DIR)/*.lot $(OUTPUT_DIR)/*.bbl $(OUTPUT_DIR)/*.blg $(OUTPUT_DIR)/*.dvi

# Full clean (remove all generated files)
clean: clean-temp
	@echo "Removing generated PDF..."
	rm -f $(OUTPUT_DIR)/$(PDF)

# Open the PDF with the default viewer (Linux only)
view: $(OUTPUT_DIR)/$(PDF)
	@echo "Opening PDF..."
	xdg-open $(OUTPUT_DIR)/$(PDF)

# Help target
help:
	@echo "Available targets:"
	@echo "  all        - Compile the LaTeX document (default)"
	@echo "  clean-temp - Remove temporary LaTeX files but keep the PDF"
	@echo "  clean      - Remove all generated files including the PDF"
	@echo "  view       - Open the PDF with the default viewer (Linux only)"