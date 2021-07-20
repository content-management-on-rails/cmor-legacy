#!/bin/bash -l
ls -d cmor_*/ | parallel -j 4 'cd {} && ./initialize_dummy.sh && bundle exec rspec -f d > spec_result~'
