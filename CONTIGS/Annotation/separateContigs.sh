#!/bin/bash

cd /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation

listOfData=$(cat annot.csv | tail -n +2 | cut -f 2 | sort | uniq)

for type in $listOfData;
do
  mkdir $type
  declare -a alignmentList
  alignmentList=(tail -n +2 /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/"$type"_table.csv | cut -f 1)
  ln -s /data/schwartzlab/eren/Chapter1/SISRS_Run/contigs_outputs/${alignmentList[*]} /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/$type/
done
