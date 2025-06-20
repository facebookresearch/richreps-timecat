#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
##
## Purpose: Filter and process **final results** of experiment in bulk.
##   This script gathers the final 'best accuracy' of any experiments
##   matching all specified patterns.
##
## Usage: `./acc1_final.sh <pattern_1> <pattern_2>  ... <pattern_k>`
##
##
## Example Use Case: `acc1 inat 1e-[56] sfadamw cat 80k` prints the 
##   overall best accuracy from all **finished** experiment with a results path
##   containing all of 'inat', '1e-5' or '1e-6', 'sfadamw', 'cat', and '80k'.
##

grep_full="grep -a 'a'"
all_search=""
num=$#
if [ $num -gt 0 ]; then
    for arg in "$@"
    do
	grep_i="grep -a ${arg}"
	grep_full="${grep_full} | ${grep_i}"
	all_search="${all_search}, ${arg}"
    done
    echo "filtering for: ${all_search}"
fi
CAT_EXP_HOME=$(dirname "$0")
results=$CAT_EXP_HOME/results/supervised/imagenet/transfer/
pattern="Top-1 test accuracy: [0-9]\+\.[0-9]\+"

# Use the find command to locate all files named "train.log" recursively
find "${results}" -type f -name 'train.log' | eval "${grep_full}" | while read -r file; do
    echo "$file"
    grep -a -io "Epoch\\[[1-9][0-9]*\\]" "$file" | tail -n 1
    grep -a -o "$pattern" "$file" | tail -n 1
done
