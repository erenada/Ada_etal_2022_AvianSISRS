#!/bin/bash
#SBATCH --job-name="concordValues"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --ntasks-per-node=20  # CHANGE THIS to processor core(s) per node
#SBATCH --nodes=1
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o UTR_loci_%A.out
#SBATCH -e UTR_loci_%A.err
#SBATCH --exclusive

#get started here

## Calculating gene/locus trees

module purge

module load GCC/9.3.0
module load GCCcore/9.3.0
module load OpenMPI/4.0.3-GCC-9.3.0
#module load CMake/3.15.3-GCCcore-8.3.0
#module load libGLU/9.0.1-GCCcore-8.3.0
#module load GLib/2.62.0-GCCcore-8.3.0
#module load g2lib/3.1.0-GCCcore-8.3.0
#module load Eigen/3.3.7

#module load IQ-TREE/2.1.2-foss-2020a

#REF_TREE=/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees

ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/CONCAT

cd $ALN_DIR

/data/schwartzlab/eren/programs/iqtree-2.1.3-Linux/bin/iqtree2 -nt AUTO -s ${ALN_DIR}/UTR/UTR_concat.fasta -S ${ALN_DIR}/UTR/UTR_partition.txt --prefix UTR_loci

