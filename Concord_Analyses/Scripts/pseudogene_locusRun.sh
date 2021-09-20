#!/bin/bash
#SBATCH --job-name="concordValues"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --ntasks-per-node=20  # CHANGE THIS to processor core(s) per node
#SBATCH --nodes=1
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o pseudogene_loci_%A.out
#SBATCH -e pseudogene_loci_%A.err
#SBATCH --exclusive

#get started here

## Calculating gene/locus trees

module purge

module load GCC/9.3.0
module load GCCcore/9.3.0
module load OpenMPI/4.0.3-GCC-9.3.0


ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/CONCAT

cd $ALN_DIR

/data/schwartzlab/eren/programs/iqtree-2.1.3-Linux/bin/iqtree2 -nt AUTO -s ${ALN_DIR}/pseudogene/pseudogene_concat.fasta -S ${ALN_DIR}/pseudogene/pseudogene_partition.txt --prefix pseudogene_loci
