#!/bin/bash

# Run from command line as: bash test_all.sh

% Clear screen
printf "\033c"

echo "************************************************"
echo "Writting all cases (1a, 2a, 3a, 4, 5) to MongoDB"
echo "************************************************"
./write_all

echo "************************************************"
echo "Call optimization"
echo "************************************************"
./main

echo "************************************************"
echo "Reading result from MongoDB for all cases"
echo "************************************************"
./read_all
