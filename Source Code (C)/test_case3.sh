#!/bin/bash

# Run from command line as: bash test_case3.sh

% Clear screen
printf "\033c"

echo "***********************************************"
echo "Writting case 3 to MongoDB"
echo "***********************************************"
./write_case3

echo "***********************************************"
echo "Call optimization"
echo "***********************************************"
./main

echo "***********************************************"
echo "Reading result from MongoDB for case 3"
echo "***********************************************"
./read_all
