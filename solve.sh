#!/bin/bash

QUERY_FILE="day$1.sql"
INPUT_FILE="input_day$1.txt"

if [ -n "$2" ]; then
    INPUT_FILE="bigboy_day$1.txt"
fi
clickhouse local --queries-file $QUERY_FILE --file $INPUT_FILE --input-format 'LineAsString'
