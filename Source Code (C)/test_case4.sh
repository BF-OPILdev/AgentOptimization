#!/bin/bash

# Run from command line as: bash test_case4.sh

% Clear screen
printf "\033c"

echo "***********************************************"
echo "Writting case 4 to MongoDB"
echo "***********************************************"
./write_case4

echo "***********************************************"
echo "Call optimization"
echo "***********************************************"
./main

echo "***********************************************"
echo "Reading result from MongoDB for case 4"
echo "***********************************************"
./read_all
