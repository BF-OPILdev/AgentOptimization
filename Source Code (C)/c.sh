#!/bin/bash

# Run from command line as: bash c.sh

echo "Compiling write_case1.c"
gcc -g -o write_case1 write_case1.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling write_case2.c"
gcc -g -o write_case2 write_case2.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling write_case3.c"
gcc -g -o write_case3 write_case3.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling write_case4.c"
gcc -g -o write_case4 write_case4.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling write_case5.c"
gcc -g -o write_case5 write_case5.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling write_all.c"
gcc -g -o write_all write_all.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling read_all.c"
gcc -g -o read_all read_all.c $(pkg-config --libs --cflags libmongoc-1.0) -lm

echo "Compiling main.c"
gcc -g -o main main.c $(pkg-config --libs --cflags libmongoc-1.0) -lm
