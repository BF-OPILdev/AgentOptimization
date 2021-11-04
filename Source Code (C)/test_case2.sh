#!/bin/bash
# Run from command line as: bash test_case2.sh

% Clear screen
printf "\033c"

echo "***********************************************"
echo "Writting case 2 to MongoDB"
echo "***********************************************"
./write_case2

echo "***********************************************"
echo "Call optimization"
echo "***********************************************"
./main

echo "***********************************************"
echo "Reading result from MongoDB for case 2"
echo "***********************************************"
./read_all
