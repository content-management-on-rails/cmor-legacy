#!/bin/bash -l
for d in ./cmor_*/ ; do (cd "$d" && ./initialize_dummy.sh && bundle exec rspec -f d); done