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


int
main(
   int argc,
   char **argv
)
{

   // Register test cases //
   const static test_case_t test_cases[] = {
      {"/example/1", test_case_1},
      {"/example/2", test_case_2},
      {NULL, NULL}
   };

   return run_unittest(argc, argv, test_cases);

}

