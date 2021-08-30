#!/bin/bash

listOfData=$(cat annot.csv | tail -n +2 | cut -f 2 | sort | uniq)

for type in $listOfData;
do
  mkdir $type
  done


for folder in $listOfData;
do
   ln -s /data/schwartzlab/eren/Chapter1/CONTIGS/contigs_5_missing/$(tail -n +2 "$folder"_table.csv | cut -f 1) /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/$folder/
done
