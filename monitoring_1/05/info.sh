function info() {
    cd $1
    TOTAL_NUMBER_OF_DIRS=$(find . -type d 2>/dev/null | wc -l)
    TOTAL_NUMBER_OF_FILES=$(find . -type f 2>/dev/null | wc -l)
    TOP5_DIRS=$(du -h . 2>/dev/null | sort -hr | head -5 | awk 'BEGIN { i = 1 }{ printf "%d - %s - %s\n", i, $2, $1, ++i }')
    LIST_FILES=$(find . -type f -exec du -h {} 2>/dev/null | sort -hr)
    NUMBER_TXT=$(find . -type f -name "*.txt" -o -name "*.md" 2>/dev/null | wc -l)
    NUMBER_LOG=$(find . -type f -name "*.log" 2>/dev/null | wc -l)
    NUMBER_CONF=$(find . -type f -name "*.conf" 2>/dev/null | wc -l)
    NUMBER_EXE=$(find . -type f -executable 2>/dev/null | wc -l)
    NUMBER_TAR=$(find . -type f -name "*.tar" -name "*.zip" -name "*.gz" 2>/dev/null | wc -l)
    NUMBER_LINKS=$(find . -type l 2>/dev/null | wc -l)

    TOP10_FILES=$(find . -type f -exec du -h {} + 2>/dev/null | sort -hr | head -10 | awk 'BEGIN { i = 1 }{ split($2, a, "."); printf "%d - %s - %s - %s\n", i, $2, $1, a[length(a)]; ++i }') 

    TOP_10_EXECUTABLES=$(find . -type f -executable 2>/dev/null | sort -hr | head -10 | awk 'BEGIN { i = 1 }{printf "%d - %s - %s - %s\n", i, $2, $1, ++i}')

    echo "Total number of folders (including all nested ones)      =" $TOTAL_NUMBER_OF_DIRS
    echo "Top 5 folders with largest size in descending order (path and size):"
    echo -e "$TOP5_DIRS"
    echo ""
    echo "     Number of files:"
    echo "Total number of files                                    =" $TOTAL_NUMBER_OF_FILES
    echo "configuration files (.conf)                              =" $NUMBER_CONF
    echo "text files (.txt)                                        =" $NUMBER_TXT
    echo "executable files (.exe)                                  =" $NUMBER_EXE
    echo "log files (.log)                                         =" $NUMBER_LOG
    echo "archives                                                 =" $NUMBER_TAR
    echo "symbolic links                                           =" $NUMBER_LINKS
    echo ""
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    echo ""
    echo -e "$TOP10_FILES"
    echo ""
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    echo ""
    echo -e "$TOP_10_EXECUTABLES"

    echo ""
}