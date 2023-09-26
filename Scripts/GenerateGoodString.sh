#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <number_of_lines> <filename> [max_line_length]"
    exit 1
fi

num_lines=$1
filename=$2
total_words=$(wc -l < "$filename")
max_line_length=${3:-$total_words}

for _ in $(seq 1 "$num_lines"); do
    line_length=$(( RANDOM % max_line_length + 1 ))
    
    for _ in $(seq 1 $line_length); do
        awk "NR == $(( RANDOM % total_words + 1 ))" "$filename" | tr -d '\n'
        echo -n " "
    done
    echo
done
