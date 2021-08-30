#!/bin/bash

listOfData=$(cat annot.csv | tail -n +2 | cut -f 2 | sort | uniq)

for type in $listOfData;
do
  mkdir $type
  done


for folder in $listOfData;
do
  contigName=$(tail -n +2 "$file"_table.csv | cut -f 1)
   ln -s /data/schwartzlab/eren/Chapter1/CONTIGS/contigs_5_missing/$contigName /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/$folder
done
