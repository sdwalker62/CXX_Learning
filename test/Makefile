CXX = clang++
CXXFLAGS = -std=c++17 -Wall -Wextra -pedantic
DEBUGFLAGS = -g -fsanitize=address,undefined

# Build specific target
%: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ $

# Build with debugging
debug-%: %.cpp
	$(CXX) $(CXXFLAGS) $(DEBUGFLAGS) -o $@ $

# Build all examples in current directory
all:
	@for file in *.cpp; do \
		echo "Building $$file..."; \
		$(CXX) $(CXXFLAGS) -o $${file%.cpp} $$file; \
	done

clean:
	rm -f *.o
	find . -type f -executable -delete

.PHONY: all clean