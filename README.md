# CXX_Learning

## Installation

### Make

```bash
# Install build dependencies
sudo apt update
sudo apt install build-essential wget

# Download the latest GNU Make source
cd /tmp
wget https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
tar -xzf make-4.4.1.tar.gz
cd make-4.4.1

# Configure, compile, and install
./configure --prefix=/usr/local
make
sudo make install
```

### CMake

```bash
# Install build dependencies
sudo apt update
sudo apt install build-essential libssl-dev

# Download source
wget https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3.tar.gz
tar -xzf cmake-4.0.3.tar.gz
cd cmake-4.0.3

# Configure and build
./bootstrap --prefix=/usr/local
make -j$(nproc)
sudo make install
```

### LLVM

```bash
# Install dependencies
sudo apt update
sudo apt install build-essential cmake ninja-build python3

# Clone LLVM repository
git clone https://github.com/llvm/llvm-project.git
cd llvm-project

# Create build directory
mkdir build && cd build

# Configure with CMake
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;compiler-rt" \
      -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
      -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      ../llvm

# Build (this takes a while and uses lots of resources)
ninja

# Install
sudo ninja install
```

### Conan

[Conan Website](https://conan.io/)

```bash
# Install pipx
sudo apt update
sudo apt install pipx

# Install Conan with pipx
pipx install conan

# Ensure pipx bin directory is in PATH
pipx ensurepath
source ~/.bashrc
```

### Install Valgrind

```bash
sudo apt install valgrind
```

### Doxygen

```bash
sudo apt install doxygen graphviz
```

### Install VS Code Extensions

```bash
code --install-extension vadimcn.vscode-lldb
code --install-extension llvm-vs-code-extensions.vscode-clangd
code --install-extension ms-vscode.cmake-tools
code --install-extension twxs.cmake
code --install-extension sonarsource.sonarlint-vscode
code --install-extension cschlosser.doxysgen
code --install-extension christian-kohler.path-intellisense
code --install-extension ms-vscode.cpptools
```

## VS Code Settings

```json

  // C++ Settings
  "C_Cpp.default.compilerPath": "/usr/local/bin/clang++",
  "C_Cpp.default.cStandard": "c17",
  "C_Cpp.default.cppStandard": "c++20",
  "C_Cpp.default.includePath": [
      "${workspaceFolder}/**",
      "/usr/local/include",
      "/usr/local/include/c++/v1"
  ],
  "C_Cpp.default.defines": [],
  "C_Cpp.default.compileCommands": "${workspaceFolder}/build/compile_commands.json",
  "clangd.path": "/usr/local/bin/clangd",
  "clangd.arguments": [
      "--compile-commands-dir=${workspaceFolder}/build",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed"
  ],
  "C_Cpp.intelliSenseEngine": "disabled",
  "C_Cpp.autocomplete": "disabled",
  "C_Cpp.errorSquiggles": "disabled",
  "cmake.configureArgs": [
      "-DCMAKE_C_COMPILER=/usr/local/bin/clang",
      "-DCMAKE_CXX_COMPILER=/usr/local/bin/clang++",
      "-DCMAKE_LINKER=/usr/local/bin/ld.lld"
  ],
  "cmake.generator": "Ninja",
  "cmake.exportCompileCommandsFile": true,
  "clang-format.executable": "/usr/local/bin/clang-format",
  "[cpp]": {
      "editor.defaultFormatter": "llvm-vs-code-extensions.vscode-clangd",
      "editor.formatOnSave": true
  },
  "[c]": {
      "editor.defaultFormatter": "llvm-vs-code-extensions.vscode-clangd",
      "editor.formatOnSave": true
  },

```
