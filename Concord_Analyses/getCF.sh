#!/bin/bash
#SBATCH --job-name="concordValues"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # CHANGE THIS to processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err
#SBATCH --exclusive

#get started here

## Calculating gene/locus trees

module purge

module load IQ-TREE/2.1.2-foss-2020a

ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED

REF_TREE=/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees

cd $ALN_DIR

for type in $(ls $ALN_DIR);
do
  iqtree2 -S ${ALN_DIR}/${type} --prefix "$type"_loci -nt 24
  for tree in $(ls $REF_TREE)
  do
    iqtree2 -t ${REF_TREE}/${tree} --gcf "$type"_loci.treefile -p ${ALN_DIR}/${type} --scf 100 --prefix "$tree"_"$type"_concord -nt 24
  done
done
