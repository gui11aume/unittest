#ifndef _UNITTEST_PRIVATE_HEADER
#define _UNITTEST_PRIVATE_HEADER
// Standard malloc() and realloc() //
extern void *__libc_malloc(size_t size);
extern void *__libc_realloc(void *, size_t size);
// Private functions // 
int    debug_run_test_case (const test_case_t);
void * fail_prone_malloc (size_t);
void * fail_prone_realloc (void *, size_t);
int    safe_run_test_case (test_case_t); 
void   test_case_clean (int);
void   test_case_init (int);
void   unit_test_clean (void);
void   unit_test_init (void);
void   unredirect_stderr (void);
#endif
