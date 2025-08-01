# Compiler and flags
CXX = /opt/homebrew/opt/llvm/bin/clang++
CXXFLAGS = -std=c++20 -Wall -Wextra -pedantic
DEBUGFLAGS = -fsanitize=address,undefined

# Find all .cpp files recursively
SOURCES := $(shell find . -name "*.cpp" -type f)
# Generate executable names (remove .cpp extension and ./ prefix)
EXECUTABLES := $(patsubst ./%.cpp, %, $(SOURCES))

# Default target
all: $(EXECUTABLES)

# Build all release versions
all-release:
	@$(MAKE) $(patsubst %,%-release,$(EXECUTABLES))

# Rule to build each executable (debug version by default)
%: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(DEBUGFLAGS) -o $@ $<

# Build release version without debug flags
%-release: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -O2 -DNDEBUG -o $(patsubst %-release,%,$@) $<

# Clean all executables
clean:
	@echo "Cleaning executables..."
	@for exe in $(EXECUTABLES); do \
		if [ -f "$$exe" ]; then \
			rm -f "$$exe"; \
			echo "  Removed $$exe"; \
		fi; \
	done
	@echo "Cleaned all executables"

# Clean everything including compilation database and SonarQube outputs
clean-all: clean
	@rm -f compile_commands.json
	@rm -rf bw-output
	@rm -rf .sonar
	@rm -rf .scannerwork
	@echo "Cleaned all build artifacts"

# Build specific book/directory (debug versions)
# Usage: make build-primer_5e
build-%:
	@$(MAKE) $(shell find $* -name "*.cpp" 2>/dev/null | sed 's/.cpp//')

# Build specific book/directory (release versions)
# Usage: make build-primer_5e-release
build-%-release:
	@$(MAKE) $(shell find $(patsubst build-%-release,%,$@) -name "*.cpp" 2>/dev/null | sed 's/.cpp//-release/')

# Run a specific chapter (usage: make run TARGET=primer_5e/variables/variables)
run:
	@if [ -z "$(TARGET)" ]; then \
		echo "Usage: make run TARGET=primer_5e/variables/variables"; \
	else \
		./$(TARGET); \
	fi

# List all available chapters
list:
	@echo "Available chapters:"
	@find . -name "*.cpp" | sed 's|^\./||; s|\.cpp$$||' | sort

# Generate compile_commands.json using Bear
bear:
	@echo "Generating compile_commands.json with Bear..."
	@bear -- $(MAKE) clean all
	@echo "compile_commands.json generated successfully"

# Run SonarQube analysis using build-wrapper
sonar-wrapper:
	@echo "Running build with SonarQube build-wrapper..."
	@if command -v build-wrapper-linux-x86-64 >/dev/null 2>&1; then \
		build-wrapper-linux-x86-64 --out-dir bw-output $(MAKE) clean all; \
	elif command -v build-wrapper-macosx-x86 >/dev/null 2>&1; then \
		build-wrapper-macosx-x86 --out-dir bw-output $(MAKE) clean all; \
	else \
		echo "Error: SonarQube build-wrapper not found in PATH"; \
		echo "Please install it from your SonarQube server"; \
		exit 1; \
	fi

# Run SonarQube scanner
sonar: sonar-wrapper
	@echo "Running SonarQube scanner..."
	@if command -v sonar-scanner >/dev/null 2>&1; then \
		sonar-scanner; \
	else \
		echo "Error: sonar-scanner not found in PATH"; \
		echo "Please install sonar-scanner"; \
		exit 1; \
	fi

# Quick analysis: generate compile_commands.json and run sonar
analyze: bear sonar
	@echo "Analysis complete!"

# Phony targets (targets that don't create files with their names)
.PHONY: all all-release clean clean-all list run build-% build-%-release bear sonar sonar-wrapper analyze