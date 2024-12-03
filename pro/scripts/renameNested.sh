#!/bin/bash


for d in  cassette_*; do
  echo "Entering: ${d}"
  cd ${d}
  for f in *.vcf.Valid; do
    echo "Renaming: ${f}"
    n=$(echo ${f} | sed s:.Valid:.Validate:)
    mv ${f} ${n}
  done
  cd ..
done
