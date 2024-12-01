#!/bin/bash

clickhouse local --queries-file "day$1.sql" --file "input_day$1.txt" --input-format 'LineAsString'