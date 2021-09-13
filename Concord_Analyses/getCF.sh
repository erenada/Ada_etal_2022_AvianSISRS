#!/bin/bash
#SBATCH --job-name="concordValues"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
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

ALN_DIR=$(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED)

REF_TREE=$(/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees)

cd $ALN_DIR

for type in $(ls $ALN_DIR);
do
  iqtree -S ${ALN_DIR}/${type} --prefix "$type"_loci -T AUTO
  for tree in $(ls $REF_TREE);
  do
    iqtree -t ${REF_TREE}/${tree} --gcf ${ALN_DIR}/${type}/"$type"_loci -p ${ALN_DIR}/${type} --scf 100 --prefix "$type"concord -T 20
  done
done
