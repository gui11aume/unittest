#include "example.h"
#include "unittest.h"


void
test_case_1
(void)
{
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
   redirect_stderr();
   errmsg();
   unredirect_stderr();
   test_assert_stderr("wrong error message");
}


void
test_case_5
(void)
{
   char * c = call_malloc(); 
   test_assert_critical(c != NULL);
   free(c);
   set_alloc_failure_rate_to(1.0);
   c = call_malloc();
   reset_alloc();
   test_assert(c == NULL);
}


int
main(
   int argc,
   char **argv
)
{

   // Register test cases //
   const static test_case_t test_cases[] = {
      {"example/1", test_case_1},
      {"example/2", test_case_2},
      {"stderr/1", test_case_3},
      {"stderr/2", test_case_4},
      {"malloc/1", test_case_5},
      {NULL, NULL}
   };

   return run_unittest(argc, argv, test_cases);

}

