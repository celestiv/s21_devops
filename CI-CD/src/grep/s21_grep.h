#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define SYMBOLS 4096

typedef struct flags {
  int c;
  int e;
  int f;
  int h;
  int i;
  int l;
  int n;
  int o;
  int s;
  int v;
  int illegalFlag;
  int flag_count;
  int file_count;
} flags;

const char* short_options = "e:ivclnshf:o?";

const struct option long_options[] = {{"count", 0, 0, 'c'},
                                      {"regexp=", 0, 0, 'e'},
                                      {"file", 0, 0, 'f'},
                                      {"no-filename", 0, 0, 'h'},
                                      {"ignore-case", 0, 0, 'i'},
                                      {"files-with-matches", 0, 0, 'l'},
                                      {"line-number", 0, 0, 'n'},
                                      {"only-matching", 0, 0, 'o'},
                                      {"no-messages", 0, 0, 's'},
                                      {"invert-match", 0, 0, 'v'},
                                      {0, 0, 0, 0}};

flags parse_patterns(int argc, char** argv, char* patterns);
int read_f_patterns(char* filename, char* patterns);

void open_files(int argc, char** argv, flags* Flags, char* patterns);

void output_flags(char* filename, flags* Flags, regex_t* re);

void flag_o(regex_t re, char* buffer, size_t nmatch, regmatch_t* pmatch);