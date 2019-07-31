#!/bin/bash -l
gem update --system
bundle update

for d in ./cmor_*/ ; do (cd "$d" && bundle); done