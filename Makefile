P= runtests
OBJECTS= example.o tests.o libunittest.so
CFLAGS= -std=gnu99 -g -Wall -O0
	#-fprofile-arcs -ftest-coverage -pg
LDLIBS= -L`pwd` -Wl,-rpath=`pwd` -lunittest
CC= gcc
$(P): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LDLIBS) -o $(P)

clean:
	rm -f $(P) $(OBJECTS) *.gcda *.gcno *.gcov .inspect.gdb

libunittest.so: unittest.c
	$(CC) -fPIC -shared $(CFLAGS) -o libunittest.so unittest.c

test: $(P)
	./$(P)

inspect: $(P)
	gdb --command=.inspect.gdb --args $(P)

valgrind: $(P)
	valgrind --vgdb=yes --vgdb-error=0 ./$(P)
