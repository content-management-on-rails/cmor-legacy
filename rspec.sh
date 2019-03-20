#!/bin/bash -l
echo "GEM"
echo $GEM
cd $GEM
rvm use $rvm_ruby_string
echo "RUBY VERSION"
ruby -v
echo "RAILS VERSION"
rails -v
bundle install
rspec -f d