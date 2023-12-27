#ifndef CAT_CONST
#define SYMBOLS 4096
#endif

#ifndef CAT_FUNCTIONS
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef CAT_FLAGS
#define CAT_FLAGS

typedef struct flags {
  int b;
  int e;
  int n;
  int s;
  int t;
  int v;
} Flags;
#endif

struct flags parse_flags(int argc, char* argv[], int* illegalFlag);
void cat_input_back();
void transform_text(FILE* fp, struct flags Flags);
#endif