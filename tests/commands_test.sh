#!/bin/bash

export GREP="grep"
. tests/assert.sh -v

src="./remote-branch-housekeeping"

assert_raises "$src" 0
assert_contains "$src -h" "Branch Housekeeping" 
assert_contains "$src -a" "Fetching branches" 
assert_contains "$src -a" "Deleting branches"
assert_contains "$src -a" "Conditions"
assert_contains "$src -a" "commits older than 14 days"
assert_contains "$src -a" "branch fully merged into origin master"

assert_end
