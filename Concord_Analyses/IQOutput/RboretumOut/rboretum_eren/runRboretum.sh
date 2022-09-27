#!/bin/bash
#SBATCH --job-name="rboretum"
#SBATCH --time=72:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=1   # CHANGE THIS to the number of processors
#SBATCH -c 12
#SBATCH --mem=500GB
#SBATCH --exclusive

## Rboretum in Andromeda

module load R/4.0.3-foss-2020b
module load Biopython/1.78-foss-2020b

Rscript RboretumScript.R
