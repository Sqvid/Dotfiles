BIN ?= main
OBJS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

CXXFLAGS ?= -std=c++17 -Wpedantic -Wall -Wextra -Wshadow -Wnon-virtual-dtor \
-Wold-style-cast -Wcast-align -Wuseless-cast -Wconversion -Wno-sign-conversion \
-Wdouble-promotion -Wnull-dereference -Wsuggest-override -Woverloaded-virtual \
-Wmisleading-indentation -Wduplicated-cond -Wformat=2 \

# Debug flags.
DBGFLAGS ?= -g3 -Og

# Sanitizer flags.
SANFLAGS ?= -fsanitize=address,undefined

# Optimisation flag.
OPTFLAG ?= -O2 -DNDEBUG

# Linked libraries.
LDFLAGS ?=
LDLIBS ?=

# Target debug build by default.
CXXFLAGS += $(DBGFLAGS)

# Compile binary.
$(BIN): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDLIBS)

# For release build: remove debug flags and optimise.
release: CXXFLAGS := $(filter-out $(DBGFLAGS), $(CXXFLAGS))
release: CXXFLAGS += $(OPTFLAG)
release: $(BIN)

# Compile with sanitizers.
sanitized: CXXFLAGS += $(SANFLAGS)
sanitized: $(BIN)

.PHONY: clean
clean:
	$(RM) *.o
	$(RM) $(BIN)
