CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -pedantic
DBGFLAGS = -g -fsanitize=address -fsanitize=bounds -lubsan
OPTFLAG = -O3

BIN =

%.o: %.c
	$(CC) $(CFLAGS) -c $^

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
