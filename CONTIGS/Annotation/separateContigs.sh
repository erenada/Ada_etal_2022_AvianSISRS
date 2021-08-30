#!/bin/bash

listOfData=$(tail -n +2 annot_table.csv | cut -f 2 | sort | uniq)

for type in $listOfData;
do
  mkdir $type
  done


for file in $(ls "$listOfData"_table.csv);
do
  contigName=$(tail -n + 2 $file | cut -f 1)
   ln -s /data/schwartzlab/eren/Chapter1/CONTIGS/contigs_5_missing/$contigName /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/$listOfData
done
