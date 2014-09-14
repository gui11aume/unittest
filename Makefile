P= test_example
OBJECTS= example.o libunittest.so
CFLAGS= -std=gnu99 -g -Wall -O0
	#-fprofile-arcs -ftest-coverage -pg
LDLIBS= -L`pwd` -Wl,-rpath=`pwd` -lunittest
CC= gcc
$(P): $(OBJECTS)

clean:
	rm -f $(P) *.o *.so *.gcda *.gcno *.gcov .inspect.gdb

libunittest.so: unittest.c
	        $(CC) -fPIC -shared $(CFLAGS) -o libunittest.so unittest.c

test: $(P)
	./$(P)

inspect: $(P)
	gdb --command=.inspect.gdb --args $(P)

valgrind: $(P)
	valgrind --vgdb=yes --vgdb-error=0 ./$(P)
