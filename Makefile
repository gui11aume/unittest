vpath %.c lib
vpath %.h lib

P= runtests

OBJECTS= tests_yourcode.o libunittest.so
SOURCES= yourcode.c
HEADERS= yourcode.h
INCLUES= lib

CC= gcc
INCLUDES= -Ilib
COVERAGE= -fprofile-arcs -ftest-coverage
CFLAGS= -std=gnu99 -g -Wall -O0 $(INCLUDES) $(COVERAGE)
LDLIBS= -L. -lunittest -lpthread

# Use different flags on Linux and MacOS.
ifeq ($(shell uname -s),Darwin)
        libflag= -dynamiclib
else
        libflag= -shared
endif


$(P): $(OBJECTS) $(SOURCES) $(HEADERS) runtests.c
	$(CC) $(CFLAGS) runtests.c $(OBJECTS) $(LDLIBS) -o $@

clean:
	rm -rf $(P) $(OBJECTS) *.gcda *.gcno *.gcov .inspect.gdb libunittest*

libunittest.so: unittest.c
	$(CC) -fPIC $(libflag) $(CFLAGS) -o libunittest.so lib/unittest.c

test: $(P)
	./$(P)

inspect: $(P)
	gdb --command=.inspect.gdb --args $(P)

valgrind: $(P)
	#valgrind --vgdb=yes --vgdb-error=0 ./$(P)
	valgrind --leak-check=full ./$(P)

vgdb: $(P)
	valgrind --vgdb=yes --vgdb-error=0 ./$(P)
