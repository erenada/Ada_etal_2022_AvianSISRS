#!/bin/bash


ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED

REF_TREE=/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees

cp /data/schwartzlab/eren/Chapter1/Concord_Analyses/Template.sh ${ALN_DIR}/Template.sh

cd $ALN_DIR

for type in $(ls -d */ | sed -e "s/\///g");
do
  echo "iqtree2 -S ${ALN_DIR}/${type}/ --prefix "${type}"_loci -nt 24" > "${type}"_temp.sh
  cat Template.sh "${type}"_temp.sh > "${type}"_locusRun.sh
  mv "${type}"_locusRun.sh /data/schwartzlab/eren/Chapter1/Concord_Analyses/"${type}"_locusRun.sh
done

rm *_temp.sh
rm Template.sh
