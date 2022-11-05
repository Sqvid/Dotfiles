CC = gcc
CFLAGS = -std=c99 -Wpedantic -Wall -Wextra
#CPPFLAGS= -std=c++14 -Wpedantic -Wall -Wextra -Wshadow -Wnon-virtual-dtor \
	  -Wold-style-cast -Wcast-align -Wuseless-cast -Wsign-conversion \
	  -Wdouble-promotion -Wnull-dereference -Wmisleading-indentation \
	  -Wduplicated-cond -Wformat=2
DBGFLAGS = -g -fsanitize=address -fsanitize=bounds -lubsan
OPTFLAG = -O3

BIN =

%.o: %.c
	$(CC) $(CFLAGS) -c $^
	#$(CC) $(CPPFLAGS) -c $^

$(BIN): *.o
	$(CC) $(CFLAGS) -o $@ $^
	#$(CC) $(CPPFLAGS) -o $@ $^

debug: CFLAGS += $(DBGFLAGS)
debug : $(BIN)

release: CFLAGS += $(OPTFLAG)
release: $(BIN)

.PHONY: clean
clean:
	rm *.o
	rm $(BIN)
