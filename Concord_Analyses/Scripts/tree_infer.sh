#!/bin/bash
#SBATCH --job-name="inferredTree"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --ntasks-per-node=20  # CHANGE THIS to processor core(s) per node
#SBATCH --nodes=1
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o treeinfer_%A.out
#SBATCH -e treeinfer_%A.err
#SBATCH --exclusive

#get started here

## Calculating gene/locus trees

module purge

module load GCC/9.3.0
module load GCCcore/9.3.0
module load OpenMPI/4.0.3-GCC-9.3.0


CONTIG_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/CONCAT

OUT_DIR=/data/schwartzlab/eren/Chapter1/Concord_Analyses/InferredTrees


for type in $(ls $CONTIG_DIR);
do
  iqtree2 -s ${CONTIG_DIR}/${type}/"${type}"_concat.fasta -p ${CONTIG_DIR}/${type}/"${type}"_partition.txt  --prefix "${type}"_infdtree -B 1000 -T AUTO
  mv *infdtree
done
