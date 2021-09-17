#!/bin/bash
#SBATCH --job-name="concordValues"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=24  # CHANGE THIS to processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o UTR_loci_%A.out
#SBATCH -e UTR_loci_%A.err
#SBATCH --exclusive
#SBATCH --mem=64GB

#get started here

## Calculating gene/locus trees

module purge
module load GCC/9.3.0
module load GCCcore/9.3.0
module load OpenMPI/4.0.3-GCC-9.3.0
module load IQ-TREE/2.1.2-foss-2020a


ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED

REF_TREE=/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees

cd $ALN_DIR

mpirun -np 4 iqtree2-mpi -nt 2 -S /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED/UTR/ --prefix UTR_loci
