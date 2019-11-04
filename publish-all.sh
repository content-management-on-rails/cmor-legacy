#!/bin/bash -l
shopt -s expand_aliases
source ~/.bash_aliases

echo $PWD
publish_gem

for i in blog carousels cms contact core core_frontend files galleries links partners seo showcase rbac suite testimonials tags user_area; do
  cd "cmor_${i}"
  echo $PWD
  publish_gem
  cd ..
done

for i in blog carousels cms contact core files galleries links rbac system testimonials tags user_area; do
  cd "cmor_${i}_backend"
  echo $PWD
  publish_gem
  cd ..
done

for i in partners seo showcase; do
  cd "cmor_${i}_frontend"
  echo $PWD
  publish_gem
  cd ..
done
