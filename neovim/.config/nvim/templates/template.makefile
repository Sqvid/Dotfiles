CC = gcc
#CC = g++
#CFLAGS = -std=c99 -Wpedantic -Wall -Wextra
#CFLAGS= -std=c++17 -Wpedantic -Wall -Wextra -Wshadow -Wnon-virtual-dtor \
	  -Wold-style-cast -Wcast-align -Wuseless-cast -Wsign-conversion \
	  -Wdouble-promotion -Wnull-dereference -Wmisleading-indentation \
	  -Wduplicated-cond -Wformat=2
DBGFLAGS = -g -O0 -fsanitize=address -fsanitize=bounds -lubsan
OPTFLAG = -O2

BIN =

%.o: %.c
	$(CC) $(CFLAGS) -c $^

#%.o: %.cpp
#	$(CC) $(CFLAGS) -c $^

$(BIN): *.o
	$(CC) $(CFLAGS) -o $@ $^

debug: CFLAGS += $(DBGFLAGS)
debug : $(BIN)

release: CFLAGS += $(OPTFLAG)
release: $(BIN)

.PHONY: clean
clean:
	rm *.o
	rm $(BIN)
