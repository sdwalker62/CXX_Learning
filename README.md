# CXX_Learning

## Installation

### Install Latest of Make

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
