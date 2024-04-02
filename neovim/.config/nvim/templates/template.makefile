BIN = main
OBJECTS = main.o

CC = gcc
CXX = g++

CFLAGS = -std=c99 -Wpedantic -Wall -Wextra -Wshadow -Wcast-align \
-Wconversion -Wno-sign-conversion -Wdouble-promotion -Wnull-dereference \
-Wmisleading-indentation -Wduplicated-cond -Wformat=2

CXXFLAGS = -std=c++17 -Wpedantic -Wall -Wextra -Wshadow -Wnon-virtual-dtor \
-Wold-style-cast -Wcast-align -Wuseless-cast -Wconversion \
-Wno-sign-conversion -Wdouble-promotion -Wnull-dereference \
-Wsuggest-override -Woverloaded-virtual -Wmisleading-indentation \
-Wduplicated-cond -Wformat=2

# Debug flags.
DBGFLAGS = -g3 -O0

# Sanitizer flags.
SANFLAGS = -fsanitize=address,leak,undefined

# Optimisation flag.
OPTFLAG = -O2

# Linked libraries.
LDLIBS =

# Target debug build by default.
CFLAGS += $(DBGFLAGS)
CXXFLAGS += $(DBGFLAGS)

# Compile binary.
$(BIN): $(OBJECTS)
	$(CXX) -o $@ $^ $(LDLIBS)

# For release build: remove debug flags and optimise.
release: CFLAGS := $(filter-out $(DBGFLAGS), $(CFLAGS))
release: CFLAGS += $(OPTFLAG)
release: CXXFLAGS := $(filter-out $(DBGFLAGS), $(CXXFLAGS))
release: CXXFLAGS += $(OPTFLAG)
release: $(BIN)

# Compile with sanitizers.
sanitized: CFLAGS += $(SANFLAGS)
sanitized: CXXFLAGS += $(SANFLAGS)
sanitized: LDLIBS := -lasan -lubsan $(LDLIBS)
sanitized: $(BIN)

.PHONY: clean
clean:
	$(RM) *.o
	$(RM) $(BIN)
