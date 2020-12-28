#!/bin/bash -
luacheck *.lua

lua -lluacov utf8_str_test.lua -v
luacov

line=`grep -n "^Summary$" luacov.report.out | awk -F ':' '{print $1}'`
all_lines=`wc -l luacov.report.out | awk '{print $1}'`
tail_lines=`expr $all_lines - $line + 2`
tail -n $tail_lines luacov.report.out

rm luacov.report.out luacov.stats.out
