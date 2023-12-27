#!/bin/bash

test_count=0
success_count=0
fail_count=0
fail_tests=""

flags=(
	"i"
	"v"
	"n"
	"s"
	 "h"
)

tests=(
"F no_exist txt.txt"
"F Hello! txt.txt"
"Hello! F txt.txt"
"Hello! txt.txt F"
"F -e 88 -e 14 txt.txt"
""[a-z]" txt.txt"
"F hello! txt.txt"
"-e Hello! txt.txt"
"F -e Hello! txt.txt"
"F -e Hello! -e Goodbye! txt.txt"
"F -e Hello! -e Goodbye! txt.txt -e Numbers"
)

tests_run() {
	args=$(echo "$@" | sed "s/F/$flag/")
	grep $args > file_1
	./s21_grep $args > file_2
	((test_count++))

	if diff file_1 file_2;
	then
		echo "$test_count: SUCCESS: $args"
		((success_count++))
	else
		echo "$test_count: FAIL: $args"
		((fail_count++))
		fail_tests="$fail_tests$test_count: $args\n"
	fi

	rm file_1 file_2
}

for flag_1 in "${flags[@]}"
do
	for i in "${tests[@]}"
	do
		flag="-$flag_1"
		tests_run "$i"
		echo -e ""
	done
done

echo -e  "\nSUCCESS:$success_count\nFAIL:$fail_count\n"

if (($fail_count > 0))
then
	echo -e $fail_tests
fi

if [[ $fail_count -eq 0 ]] ; then
	exit 0
else
	exit 1
fi
