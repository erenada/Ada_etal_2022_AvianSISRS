#!/bin/bash

listOfData=$(cat annot_table.csv | cut -f 2 | sort | uniq)

for type in $listOfData;
do
  mkdir $type
  contigName=$(cut -f 1 "$type"_table.csv)
  cd $type
  cp /data/schwartzlab/eren/Chapter1/CONTIGS/contigs_5_missing/$contigName ./$type
done
