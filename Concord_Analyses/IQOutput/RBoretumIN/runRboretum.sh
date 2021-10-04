#!/bin/bash
#SBATCH --job-name="rboretum"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # CHANGE THIS to the number of processors
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=ALL
#SBATCH --exclusive
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err

cd /data/schwartzlab/eren/Chapter1/Concord_Analyses/IQOutput/RBoretumIN

## Rboretum in Andromeda

module purge

module load Biopython/1.75-foss-2019b-Python-3.7.4

module load R/3.6.2-foss-2019b

Rscript RboretumScript.R
