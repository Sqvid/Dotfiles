$(CC) = gcc
$(CFLAGS) = -Wall -Wextra -std=c99 -pedantic
$(OFLAGS) = -O3
$(LDFLAGS) =
$(DBGFLAGS) = -g

$(BIN) = a.out

$(BIN): *.o
	$(CC) $(CFLAGS) -o $(BIN) $(LDFLAGS)

%.o : %.c
	$(CC) $(CFLAGS) -c $@ $<
