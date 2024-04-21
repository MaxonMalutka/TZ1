#!/bin/bash

if [ $# -ne 2 ]; then
    echo "error. неправильное количество аргументов"
    exit 1
fi

input_dir="$1"
output_dir="$2"

if [ ! -d "$input_dir" ] || [ ! -d "$output_dir" ]; then
    echo "error. неверное содержимое"
    exit 1
fi

files1=()
directories=()

for file in "$input_dir"/*; do
    if [ -f "$file" ]; then
        files1+=("$file")
    elif [ -d "$file" ]; then
        directories+=("$file")
    fi
done

num=53349

find_all() {
    local inp="$1"
    local outp="$2" 
    
    for i in "$inp"/*; do
        if [ -f "$i" ]; then
            name=$(basename "$i")
            if [ -e "$outp/$name" ]; then
                extension="${name##*.}"
                final="${name}${num}.$extension"
                ((num+=1))
                cp "$i" "output_dir/$final"
            else
                cp "$i" "output_dir/$name"
            fi
        elif [ -d "$i" ]; then
            find_all "$i" "$outp"
        fi
    done
}
find_all "$input_dir" "$output_dir"