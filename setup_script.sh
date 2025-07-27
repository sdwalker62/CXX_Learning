#!/bin/bash
# setup_env.sh

export PATH="/usr/local/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export CC="/usr/local/bin/clang"
export CXX="/usr/local/bin/clang++"

# Verify tools are available
echo "\nClang version:"
clang --version
echo "\nClang++ version:"
clang++ --version
echo "\nNinja version:"
ninja --version
echo "\nCMake version:"
cmake --version