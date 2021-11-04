#!/bin/bash

# Run from command line as: bash test_case5.sh

% Clear screen
printf "\033c"

echo "***********************************************"
echo "Writting case 5 to MongoDB"
echo "***********************************************"
./write_case5

echo "***********************************************"
echo "Call optimization"
echo "***********************************************"
./main

echo "***********************************************"
echo "Reading result from MongoDB for case 5"
echo "***********************************************"
./read_all
