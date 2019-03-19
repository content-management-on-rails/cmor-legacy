#!/bin/bash -l
echo $PWD
rvm current
bundle install

for i in blog carousels cms contact core files galleries links rbac suite tags user_area; do
  cd "cmor_${i}"
  echo $PWD
  rvm current
  BUNDLE_GEMFILE=./Gemfile bundle install
  BUNDLE_GEMFILE=./Gemfile bundle exec rspec spec
  cd ..
done

for i in blog carousels cms contact core files galleries links rbac tags user_area; do
  cd "cmor_${i}_backend"
  echo $PWD
  rvm current
  BUNDLE_GEMFILE=./Gemfile bundle install
  BUNDLE_GEMFILE=./Gemfile bundle exec rspec spec
  cd ..
done


