#!/bin/bash -l
gem update --system
bundle install

for d in ./cmor_*/ ; do (cd "$d" && bundle); done