vpath %.c lib
vpath %.h lib

RUN=run_tests_for_coverage
DBG=run_tests_for_debug
VAL=run_tests_for_valgrind

OBJECTS= tests_yourcode.o libunittest.so
SOURCES= yourcode.c
HEADERS= yourcode.h
INCLUES= lib

ifdef TRAVIS_COMPILER
CC= $(TRAVIS_COMPILER)
else
CC= gcc
endif

INCLUDES= -Ilib
CFLAGS= -std=gnu99 -g -Wall -Wextra $(INCLUDES)
COVERAGE= -fprofile-arcs -ftest-coverage
PROFILE= -pg
LDLIBS= -L. -Wl,-rpath,. -lunittest -lz -lm -lpthread

# Use different flags on Linux and MacOS.
ifeq ($(shell uname -s),Darwin)
        libflag= -dynamiclib
else
        libflag= -shared
endif

$(RUN): CFLAGS += -O2 $(COVERAGE) $(PROFILE)
$(RUN): $(OBJECTS) $(SOURCES) $(HEADERS) runtests.c
	$(CC) $(CFLAGS) runtests.c $(OBJECTS) $(LDLIBS) -o $@

$(DBG): CFLAGS += -O0 -DDEBUG
$(DBG): $(OBJECTS) $(SOURCES)
	$(CC) $(CFLAGS) runtests.c $(OBJECTS) $(LDLIBS) -o $@

$(VAL): CFLAGS += -O2 -DVALGRIND
$(VAL): $(OBJECTS) $(SOURCES)
	$(CC) $(CFLAGS) runtests.c $(OBJECTS) $(LDLIBS) -o $@

clean:
	rm -rf $(RUN) $(DBG) $(VAL) $(OBJECTS) *.gcda *.gcno *.gcov \
		.inspect.gdb libunittest* gmon.out

libunittest.so: unittest.c
	$(CC) -fPIC $(libflag) $(CFLAGS) -o libunittest.so lib/unittest.c

test: $(RUN)
	./$(RUN)

inspect: $(DBG)
	gdb --command=.inspect.gdb --args $(DBG)

valgrind: $(VAL)
	valgrind --leak-check=full ./$(VAL)

vgdb: $(VAL)
	valgrind --vgdb=yes --vgdb-error=0 ./$(VAL)

tests_yourcode.gcda gmon.out: $(RUN)
	-./$(RUN)

cov: tests_yourcode.gcda
	gcov tests_yourcode.c
	cat yourcode.c.gcov

prof: gmon.out
	gprof ./runcov --flat-profile --brief
