#!/bin/sh

# Function to compile a C file
compile() {
    # Check if the file exists with or without the .c extension
    if [ -f "$1.c" ]; then
        filename="$1.c"
    elif [ -f "$1" ]; then
        filename="$1"
    else
        echo "Error: Source file $1.c does not exist."
        return 1
    fi

    # Compile the file
    gcc -Wall -std=c11 -g "$filename" -o "${1%.c}"
}

# Function to run a program
run() {
    if [ -f "$1" ]; then
        ./"$1"
    else
        echo "Error: Program $1 does not exist."
        return 1
    fi
}

# Function to build and then run a program
build() {
    compile "$1" && run "${1%.c}"
}

# Main script logic
case "$1" in
    compile)
        if [ -z "$2" ]; then
            echo "Error: No filename provided for compile."
            exit 1
        else
            compile "$2"
        fi
        ;;
    run)
        if [ -z "$2" ]; then
            echo "Error: No filename provided for run."
            exit 1
        else
            run "${2%.c}"
        fi
        ;;
    build)
        if [ -z "$2" ]; then
            echo "Error: No filename provided for build."
            exit 1
        else
            build "$2"
        fi
        ;;
    *)
        echo "Usage: ./b COMMAND NAME"
        echo "Commands:"
        echo "  compile NAME - Compiles the specified C file."
        echo "  run NAME     - Runs the specified program."
        echo "  build NAME   - Compiles and runs the specified C file."
        exit 1
        ;;
esac
