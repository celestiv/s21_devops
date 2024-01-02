#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF=""

s21_command=(
    "./s21_cat"
    )
sys_command=(
    "cat"
    )

tests=(
"FLAGS test_files/test_case_cat.txt"
"FLAGS test_files/test_case_cat.txt"
)
flags=(
    "b"
    "e"
    "n"
    "s"
    "t"
    "v"
)
manual=(
"-s test_files/test_1_cat.txt"
"-b test_files/test_1_cat.txt nofile.txt"
"-t test_files/test_3_cat.txt"
"-n test_files/test_2_cat.txt"
"no_file.txt"
"-n -b test_files/test_1_cat.txt"
"-s -n -e test_files/test_4_cat.txt"
"test_files/test_1_cat.txt -n"
"-n test_files/test_1_cat.txt"
"-n test_files/test_1_cat.txt"
"-v test_files/test_5_cat.txt"
"-- test_files/test_5_cat.txt"
)

function run_test() {
    param=$(echo "$@" | sed "s/FLAGS/$var/")
    "${s21_command[@]}" $param > "${s21_command[@]}".log
    "${sys_command[@]}" $param > "${sys_command[@]}".log
    DIFF="$(diff -s "${s21_command[@]}".log "${sys_command[@]}".log)"
    let "COUNTER++"
    if [ "$DIFF" == "Files "${s21_command[@]}".log and "${sys_command[@]}".log are identical" ]
    then
        let "SUCCESS++"
        echo "$COUNTER - Success $param"
    else
        let "FAIL++"
        echo "$COUNTER - Fail $param"
    fi
    rm -f "${s21_command[@]}".log "${sys_command[@]}".log
}

echo "^^^^^^^^^^^^^^^^^^^^^^^"
echo "TESTS WITH NORMAL FLAGS"
echo "^^^^^^^^^^^^^^^^^^^^^^^"
printf "\n"
for i in "${manual[@]}"
do
    var="-"
    run_test "$i"
done

printf "\n"
echo "FAILED: $FAIL"
echo "SUCCESSFUL: $SUCCESS"
echo "ALL: $COUNTER"
printf "\n"

if ! [[ "$FAIL" -eq 0 ]] ; then
	exit 1
fi
