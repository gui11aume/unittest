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
PROFILE= -pg
CFLAGS= -std=gnu99 -g -Wall -O0 $(INCLUDES) $(COVERAGE) $(PROFILE)
LDLIBS= -L. -Wl,-rpath,. -lunittest -lpthread

# Use different flags on Linux and MacOS.
ifeq ($(shell uname -s),Darwin)
        libflag= -dynamiclib
else
        libflag= -shared
endif


$(P): $(OBJECTS) $(SOURCES) $(HEADERS) runtests.c
	$(CC) $(CFLAGS) runtests.c $(OBJECTS) $(LDLIBS) -o $@

clean:
	rm -rf $(P) $(OBJECTS) *.gcda *.gcno *.gcov \
		.inspect.gdb libunittest* gmon.out

libunittest.so: unittest.c
	$(CC) -fPIC $(libflag) $(CFLAGS) -o libunittest.so lib/unittest.c

test: $(P)
	./$(P)

inspect: $(P)
	gdb --command=.inspect.gdb --args $(P)

valgrind: $(P)
	valgrind --leak-check=full ./$(P)

vgdb: $(P)
	valgrind --vgdb=yes --vgdb-error=0 ./$(P)

tests_yourcode.gcda gmon.out: $(P)
	-./$(P)

cov: tests_yourcode.gcda
	gcov tests_yourcode.c
	cat yourcode.c.gcov

prof: gmon.out
	gprof ./$(P) --flat-profile --brief

