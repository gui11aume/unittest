#ifndef _UNITTEST_PRIVATE_HEADER
#define _UNITTEST_PRIVATE_HEADER
int    debug_run_test_case (const test_case_t);
void   redirect_stderr (void);
int    safe_run_test_case (test_case_t); 
char * sent_to_stderr (void);
void   unit_test_clean (void);
void   unit_test_init (void);
void   unredirect_stderr (void);
void   test_case_clean (int);
void   test_case_init (int);
#endif
