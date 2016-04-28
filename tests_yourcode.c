#include "unittest.h"
// Include target source file to test in order to
// define all the declared symbols.
#include "yourcode.c"

// Write the test cases as function with prototype 'void (*) (void)'.
void
test_case_1
(void)
{
   // Use 'test_assert()' to assert results are as expected.
   test_assert(return_0() == 0);
   test_assert(return_1() == 1);
}


void
test_case_2
(void)
{
   test_assert(should_return_0() == 0);
   test_assert(return_0() == 0);
   test_assert(return_1() == 1);
}


void
test_case_3
(void)
{
   redirect_stderr();
   errmsg();
   unredirect_stderr();
   test_assert_stderr("error message");
}


void
test_case_4
(void)
{
   // Use 'redirect_stderr()' to record stderr.
   redirect_stderr();
   errmsg();
   // Use 'unredirect_stderr()' to stop recording.
   unredirect_stderr();
   // Use 'test_assert_stderr()' to compare the recorded
   // error message with the target.
   test_assert_stderr("wrong error message");
   // The recorded text is in 'caught_in_stderr()' .
   fprintf(stderr, "%s", caught_in_stderr());
}


void
test_case_5
(void)
{
   // In this test a segmentation fault will happen.
   // This will cause the test to fail, but the execution
   // will nevertheless continue to the next test.

   if (*(int*) 0x0 == 0) {
      printf("won't be executed (segfault before)\n");
   }

   return;

}


void
test_case_6
(void)
{
   char * c = call_malloc(); 
   // Use 'test_assert_critical()' to interrupt the test
   // in case assertion fails. In the example below 'c'
   // must not be NULL otherwise 'free(c)' will fail.
   test_assert_critical(c != NULL);
   free(c);

   // Use 'set_alloc_failure_rate_to(p)' to cause 'malloc()'
   // (including 'calloc()' and 'realloc()') to fail randomly
   // with probability 'p'.
   set_alloc_failure_rate_to(1.0);
   c = call_malloc();
   test_assert(c == NULL);
   // Set 'malloc()' to normal mode.
   reset_alloc();

   // Use 'set_alloc_failure_countdown_to(n)' to cause 'malloc()'
   // (including 'calloc()' and 'realloc()') to systematically
   // fail after 'n' calls.
   set_alloc_failure_countdown_to(1);
   c = call_malloc();
   test_assert_critical(c != NULL);
   free(c);
   // The second call to 'malloc()' will fail.
   c = call_malloc();
   test_assert(c == NULL);
   reset_alloc();

}

// Define test cases to be run (for export).
const test_case_t test_cases_from_file_1[] = {
   {"example/1", test_case_1},
   {"example/2", test_case_2},
   {"stderr/1",  test_case_3},
   {"stderr/2",  test_case_4},
   {"crash/1",   test_case_5},
   {"malloc/1",  test_case_6},
   {NULL, NULL}, // Sentinel. //
};
