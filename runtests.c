#include "unittest.h"
// Include test source.
#include "test_yourcode.c"

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

   // Run tests.
   return run_unittest(argc, argv, test_cases);

}
