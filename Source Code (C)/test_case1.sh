#!/bin/bash

# Run from command line as: bash test_case1.sh

% Clear screen
printf "\033c"

echo "***********************************************"
echo "Writting case 1 to MongoDB"
echo "***********************************************"
./write_case1

echo "***********************************************"
echo "Call optimization"
echo "***********************************************"
./main

echo "***********************************************"
echo "Reading result from MongoDB for case 1"
echo "***********************************************"
./read_all
