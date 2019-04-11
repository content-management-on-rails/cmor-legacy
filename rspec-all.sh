#!/bin/bash -l
for d in ./cmor_*/ ; do (cd "$d" && ./initialize_dummy.sh && rspec -f d); done