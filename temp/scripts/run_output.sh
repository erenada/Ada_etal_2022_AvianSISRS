#!/bin/bash
#SBATCH --job-name="bird_out"
#SBATCH --time=96:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node 
#SBATCH --mail-user="literman@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_bird_out"
#SBATCH --error="out_bird_out"
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
cd $SLURM_SUBMIT_DIR
module load Python/3.6.4-foss-2018a
python sisrs_07_output_sisrs_Jarvis.py 0
