#!/bin/bash -l
shopt -s expand_aliases
source ~/.bash_aliases

echo $PWD
for i in blog cms2 contact2 core files galleries links2 rbac sliders2 tags user_area2; do
  cd "cmor_${i}"
  echo $PWD
  publish_gem
  cd ..
done

for i in blog cms2 contact2 core files galleries links2 rbac sliders2 suite tags user_area2; do
  cd "cmor_${i}_backend"
  echo $PWD
  publish_gem
  cd ..
done
