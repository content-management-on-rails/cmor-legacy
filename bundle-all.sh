#!/bin/bash -l
gem update --system
bundle

for d in ./cmor_*/ ; do (cd "$d" && bundle); done