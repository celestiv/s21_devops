#include "s21_grep.h"

int main(int argc, char* argv[]) {
  char patterns[SYMBOLS] = {0};
  flags Flags = parse_patterns(argc, argv, patterns);
  if (((Flags.e || Flags.f) && argc <= 2) || Flags.illegalFlag) {
    fprintf(stderr,
            "usage: grep [-abcDEFGHhIiJLlmnOoqRSsUVvwxZ] [-A num] [-B num] "
            "[-C[num]]\n");
    fprintf(stderr,
            "        [-e pattern] [-f file] [--binary-files=value] "
            "[--color=when]\n");
    fprintf(stderr,
            "        [--context[=num]] [--directories=action] [--label] "
            "[--line-buffered]\n");
    fprintf(stderr, "        [--null] [pattern] [file ...]");
  } else {
    open_files(argc, argv, &Flags, patterns);
  }
  return 0;
}

flags parse_patterns(int argc, char** argv, char* patterns) {
  flags Flags = {0};
  char option;
  while ((option = getopt_long(argc, argv, short_options, long_options,
                               NULL)) != -1) {
    if (option == 'e') {
      patterns += snprintf(patterns, SYMBOLS, "%s|", optarg);
      Flags.e++;
    } else if (option == 'f') {  // bonus flag
      int success = read_f_patterns(optarg, patterns);
      if (!success) Flags.f++;
    } else if (option == 'i') {
      Flags.i = 1;
    } else if (option == 'v') {
      Flags.v = 1;
      if (Flags.o) Flags.o = 0;
    } else if (option == 'c') {
      Flags.c = 1;
      if (Flags.n) Flags.n = 0;
    } else if (option == 'l') {
      Flags.l = 1;
    } else if (option == 'n') {
      Flags.n = 1;
    } else if (option == 's') {  // bonus flag
      Flags.s = 1;
    } else if (option == 'o') {  // bonus flag
      if (!Flags.v) Flags.o = 1;
    } else if (option == 'h') {  // bonus flag
      Flags.h = 1;
    } else if (option == '?') {
      Flags.illegalFlag = 1;
    }
  }
  if (!Flags.e && !Flags.f)
    patterns += snprintf(patterns, SYMBOLS, "%s|", argv[optind]);
  if (patterns[strlen(patterns) - 1] == '|')
    patterns[strlen(patterns) - 1] = '\0';
  return Flags;
}

void open_files(int argc, char** argv, flags* Flags, char* patterns) {
  regex_t re;
  int cflags;
  if (Flags->i == 0) {
    cflags = REG_EXTENDED;
  } else {
    cflags = REG_ICASE | REG_EXTENDED;
  }
  int regcomp_status = regcomp(&re, patterns, cflags);
  if (regcomp_status == 0) {
    if (Flags->e || Flags->f) {
      Flags->file_count = argc - optind;
      for (; optind < argc; optind++) {
        output_flags(argv[optind], Flags, &re);
      }
    } else if (!Flags->e && !Flags->f && Flags->flag_count > 0) {
      Flags->file_count = argc - optind - 1;
      for (int i = optind + 1; i < argc; i++) {
        output_flags(argv[i], Flags, &re);
      }
    } else {
      Flags->file_count = argc - optind - 1;
      for (int i = optind + 1; i < argc; i++) {
        output_flags(argv[i], Flags, &re);
      }
    }
    regfree(&re);
  } else {
    fprintf(stderr, "failed to compile regex");
  }
}

void output_flags(char* filename, flags* Flags, regex_t* re) {
  int file_exists = access(filename, F_OK);
  if (file_exists == -1 && !Flags->s) {
    fprintf(stderr, "grep: %s: No such file or directory\n", filename);
  } else {
    FILE* fp = fopen(filename, "r");
    if (fp) {
      int line_num = 0, match_count = 0, add_line = 1;
      char buffer[SYMBOLS] = {0};
      size_t nmatch = 1;
      regmatch_t pmatch[nmatch];
      while (fgets(buffer, SYMBOLS, fp) != NULL) {
        int match_found = 0;
        match_found = regexec(re, buffer, nmatch, pmatch, 0);
        line_num++;
        if (Flags->v) match_found = !match_found;
        if (!match_found)
          if (!Flags->l && !Flags->c) {
            match_count++;
            if (!Flags->h && Flags->file_count > 1) printf("%s:", filename);
            if (Flags->n) printf("%d:", line_num);
            if (Flags->o) flag_o(*re, buffer, nmatch, pmatch);
            if (!Flags->o) printf("%s", buffer);
            if (buffer[strlen(buffer) - 1] != '\n' && add_line) putchar('\n');
          }
      }
      if (Flags->c) {
        if (!Flags->h && Flags->file_count > 1) {
          printf("%s:%d\n", filename, match_count);
        }
      }
      if (Flags->l) {
        printf("%s\n", filename);
      }
      fclose(fp);
    }
  }
}

void flag_o(regex_t re, char* buffer, size_t nmatch, regmatch_t* pmatch) {
  int start_position = 0, regex_status = 0;
  while ((regex_status = regexec(&re, buffer + start_position, nmatch, pmatch,
                                 0)) != REG_NOMATCH) {
    for (int i = pmatch->rm_so; i < pmatch->rm_eo; i++) {
      putchar(buffer[i]);
    }
    start_position += pmatch->rm_eo;
    putchar('\n');
  }
}

int read_f_patterns(char* filename, char* patterns) {
  int success = 0;
  FILE* temp_file = fopen(filename, "r");
  if (temp_file == NULL) {
    success = 1;
    fprintf(stderr, "No such file");
  } else {
    char temp;
    while ((temp = fgetc(temp_file)) != EOF) {
      if (temp == '\n')
        *patterns++ = '|';
      else
        *patterns++ = temp;
    }
    *patterns++ = '|';
    fclose(temp_file);
  }
  return success;
}