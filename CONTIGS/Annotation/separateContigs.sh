#!/bin/bash

cd /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation

listOfData=$(cat annot.csv | tail -n +2 | cut -f 2 | sort | uniq)

for type in $listOfData;
do
  alignmentName=$(tail -n +2 /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/"$type"_table.csv | cut -f 1)
  mkdir $type
  ln -s /data/schwartzlab/eren/Chapter1/CONTIGS/contigs_5_missing/$alignmentName /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/$type/$alignmentName
done
