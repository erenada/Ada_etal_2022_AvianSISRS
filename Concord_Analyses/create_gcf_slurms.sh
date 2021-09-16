#!/bin/bash


ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED

REF_TREE=/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees


cd $ALN_DIR

for type in $(ls -d */ | sed -e "s/\///g");
do
  cp data/schwartzlab/eren/Chapter1/Concord_Analyses/Template.sh ./
  echo "iqtree2 -S ${ALN_DIR}/${type}/ --prefix "${type}"_loci -nt 24" > "${type}"_locusRun.sh
  cat Template.sh "${type}"_locusRun.sh > "${type}"_locusRun.sh
  mv "${type}"_locusRun.sh /data/schwartzlab/eren/Chapter1/Concord_Analyses/"${type}"_locusRun.sh
  rm Template.sh
  cd /data/schwartzlab/eren/Chapter1/Concord_Analyses/
  sbatch "${type}"_locusRun.sh
done
