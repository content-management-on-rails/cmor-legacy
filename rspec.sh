#!/bin/bash -l
unset BUNDLE_GEMFILE
echo "GEM"
echo $GEM
cd $GEM
rvm install $rvm_ruby_string
rvm use $rvm_ruby_string
echo "RUBY VERSION"
ruby -v
bundle install
echo "RAILS VERSION"
rails -v
rake db:migrate db:test:prepare
rspec -f d