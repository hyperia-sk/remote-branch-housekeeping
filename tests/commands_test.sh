#!/bin/bash

. tests/assert.sh -v

src="./remote-branch-housekeeping"

assert_raises "$src" 0
assert_contains "$src -h" "Git Remote Branch Housekeeping" 1
assert_contains "$src" "Fetching branches" 127
assert_contains "$src" "Deleting branches" 127
assert_contains "$src" "Conditions" 127
assert_contains "$src" "commits older than 14 days" 127
assert_contains "$src" "ranch fully merged into origin master" 127

assert_end
