CFLAGS=-Wall -Werror -Wextra
LIBS=-lcheck

.PHONY: clean
.PHONY: rebuild

main: s21_cat

s21_cat: s21_cat.c
	gcc $(CFLAGS) $^ -o $@

test: s21_cat
	cp ~/utils/test_scripts/tests.sh .
	./tests.sh

check:	
	cp ../../materials/linters/.clang-format .
	clang-format -i *.c
	cppcheck --enable=all --suppress=missingIncludeSystem .


clean: s21_cat
	rm s21_cat

rebuild:
	clean main