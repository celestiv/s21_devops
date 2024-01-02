#include "s21_cat.h"

int main(int argc, char* argv[]) {
  int illegalFlag = 0;
  if (argc == 1) {
    cat_input_back();
  }
  struct flags Flags = parse_flags(argc, argv, &illegalFlag);
  if (!illegalFlag) {
    for (; optind < argc; optind++) {
      FILE* fp = fopen(argv[optind], "rb");
      if (fp == NULL) {
        fprintf(stderr, "%s: %s: No such file or directory", argv[0],
                argv[optind]);
      } else {
        transform_text(fp, Flags);
        fclose(fp);
        (void)fp;
      }
    }
  } else {
    fprintf(stderr, "usage: ./s21_cat [-benstv] [file...]");
  }
  return illegalFlag;
}

struct flags parse_flags(int argc, char* argv[], int* illegalFlag) {
  struct flags Flags = {0};
  const struct option long_options[] = {
      {"number-nonblank", no_argument, NULL, 'b'},
      {"number", no_argument, NULL, 'n'},
      {"squeeze-blank", no_argument, NULL, 's'},
      {NULL, 0, NULL, 0}};
  const char* short_options = "beEnstTv?";
  char option;

  while ((option = getopt_long(argc, argv, short_options, long_options,
                               NULL)) != -1) {
    if (option == 'e') {
      Flags.e = 1;
      Flags.v = 1;
    } else if (option == 'n') {
      if (Flags.b == 0) {
        Flags.n = 1;
      }
    } else if (option == 's') {
      Flags.s = 1;
    } else if (option == 'b') {
      if (Flags.n) {
        Flags.n = 0;
      }
      Flags.b = 1;
    } else if (option == 't') {
      Flags.t = 1;
      Flags.v = 1;
    } else if (option == 'v') {
      Flags.v = 1;
    } else if (option == 'T') {
      Flags.t = 1;
    } else if (option == 'E') {
      Flags.e = 1;
    } else if (option == '?') {
      *illegalFlag = 1;
    }
  }
  return Flags;
}

void cat_input_back() {
  char curr_char;
  while ((curr_char = getchar()) != '\0') {
    putchar(curr_char);
  }
  return;
}

void transform_text(FILE* fp, struct flags Flags) {
  int prev_char = '\n', current_char;
  int empty_line_count = 0, count = 1;
  while ((current_char = fgetc(fp)) != EOF) {
    if (Flags.s) {
      if (current_char == '\n') {
        empty_line_count++;
      }
      if (current_char == '\n' && empty_line_count > 2) {
        empty_line_count++;
        continue;
      }
      if (current_char != '\n' && empty_line_count >= 1) {
        empty_line_count = 0;
      }
    }
    if (Flags.b && current_char != '\n' && prev_char == '\n') {
      printf("%6d\t", count++);
    }
    if (Flags.n && prev_char == '\n') {
      printf("%6d\t", count++);
    }
    if (Flags.e && current_char == '\n') {
      printf("$");
    }
    if (Flags.t && current_char == 9) {
      printf("^");
      current_char = 'I';
    }
    if (Flags.v) {
      if (current_char != 9 && current_char != 10 && current_char < 32) {
        printf("^");
        current_char += 64;
      } else if (current_char == 127) {
        printf("^");
        current_char = '?';
      } else if (current_char > 127 && current_char < 160) {
        current_char -= 64;
      }
    }
    putchar(current_char);
    prev_char = current_char;
  }
}
