#!/bin/bash -l
echo $PWD
rvm current
gem update --system
bundle install

# for i in blog carousels cms contact core files galleries links rbac suite tags user_area; do
for i in suite; do
  cd "cmor_${i}"
  echo $PWD
  rvm current
  BUNDLE_GEMFILE=./Gemfile bundle install
  cd spec/dummy
  BUNDLE_GEMFILE=./Gemfile bundle exec rake db:migrate db:test:prepare
  cd ../..
  BUNDLE_GEMFILE=./Gemfile bundle exec rake spec
  cd ..
done

# for i in blog carousels cms contact core files galleries links rbac tags user_area; do
#   cd "cmor_${i}_backend"
#   echo $PWD
#   rvm current
#   BUNDLE_GEMFILE=./Gemfile bundle install
#   BUNDLE_GEMFILE=./Gemfile bundle exec rspec spec
#   cd ..
# done


