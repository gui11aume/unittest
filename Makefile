P= runtests
OBJECTS= libunittest.so
SOURCES= runtests.c
CFLAGS= -std=gnu99 -g -Wall -O0
	# Add the following flags for test coverage or profiling.
	#-fprofile-arcs -ftest-coverage -pg
LDLIBS= -L`pwd` -Wl,-rpath=`pwd` -lunittest
CC= gcc
$(P): $(OBJECTS) $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) $(OBJECTS) $(LDLIBS) -o $(P)

clean:
	rm -f $(P) $(OBJECTS) *.gcda *.gcno *.gcov .inspect.gdb

libunittest.so: unittest.c
	$(CC) -fPIC -shared $(CFLAGS) -o libunittest.so unittest.c

test: $(P)
	./$(P)

inspect: $(P)
	gdb --command=.inspect.gdb --args $(P)

valgrind: $(P)
	valgrind --leak-check=full ./$(P) --debug

vgdb: $(P)
	valgrind --vgdb=yes --vgdb-error=0 ./$(P) --debug
