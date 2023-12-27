CFLAGS=-Wall -Werror -Wextra -std=c11
TEST=s test_files/test_0_grep.txt -o

all: s21_grep

ff: s21_grep
	./s21_grep $(TEST) > 1.txt
	grep $(TEST) > 2.txt
	diff 1.txt 2.txt

s21_grep: s21_grep.c
	gcc $(CFLAGS) $^ -o $@

test:
	gcc $(CFLAGS) grep_test.c -o s21_grep

simple:
	gcc $(CFLAGS) s21_grep_simple.c -o s21_grep

check:
	cp ../../materials/linters/.clang-format .
	clang-format *.c
	cppcheck --enable=all --suppress=missingIncludeSystem s21_grep.c

.PHONY: clean
clean:
	rm s21_grep

rebuild: clean all