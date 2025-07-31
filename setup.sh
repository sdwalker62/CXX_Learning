#!/bin/bash

# Setup script for C++ learning repository with Bear and SonarQube

echo "Setting up C++ learning environment..."

# Check for required tools
check_tool() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ $1 is not installed"
        return 1
    else
        echo "✅ $1 is installed"
        return 0
    fi
}

echo -e "\nChecking required tools..."
MISSING_TOOLS=0

check_tool "clang++" || MISSING_TOOLS=1
check_tool "make" || MISSING_TOOLS=1
check_tool "bear" || MISSING_TOOLS=1

# Check optional tools
echo -e "\nChecking optional tools..."
check_tool "sonar-scanner" || echo "   Install with: brew install sonar-scanner (macOS) or download from SonarQube website"
check_tool "build-wrapper-linux-x86-64" || check_tool "build-wrapper-macosx-x86" || echo "   Download from your SonarQube server"

if [ $MISSING_TOOLS -eq 1 ]; then
    echo -e "\n❌ Some required tools are missing. Please install them:"
    echo "   Ubuntu/Debian: sudo apt install clang build-essential bear"
    echo "   macOS: brew install llvm bear"
    echo "   Arch: sudo pacman -S clang base-devel bear"
    exit 1
fi

# Create necessary directories
echo -e "\nCreating directory structure..."
mkdir -p .vscode

# Initial build to generate compile_commands.json
echo -e "\nGenerating compile_commands.json..."
make bear

echo -e "\n✅ Setup complete!"
echo -e "\nUsage:"
echo "  make bear              - Generate compile_commands.json for IntelliSense"
echo "  make                   - Build all executables"
echo "  make primer_5e/variables/variables - Build specific executable"
echo "  make run TARGET=primer_5e/variables/variables - Run specific executable"
echo "  make sonar             - Run SonarQube analysis"
echo "  make analyze           - Run both Bear and SonarQube"
echo "  make list              - List all available chapters"
echo "  make clean             - Clean executables"
echo "  make clean-all         - Clean all build artifacts"

echo -e "\nVSCode Extensions to install:"
echo "  - C/C++ Extension Pack"
echo "  - Makefile Tools"
echo "  - SonarLint"