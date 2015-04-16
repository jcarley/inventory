#!/usr/bin/env bash


FILES=/home/vagrant/apps/inventory/scripts/files/nginx/*.site
shopt -s nullglob
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  basename $f
  dirname $f
done
