#include "yourcode.h"

int    return_0 (void) { return 0; }
int    return_1 (void) { return 1; }
int    should_return_0 (void) { return 1; }
void   errmsg (void) { fprintf(stderr, "error message"); }
char * call_malloc (void) { return (char *) malloc(sizeof(char)); }
