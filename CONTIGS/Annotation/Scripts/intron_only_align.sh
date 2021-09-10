#!/bin/bash
#SBATCH --job-name="align_subsets_1"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # CHANGE THIS to processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err
#SBATCH --exclusive




module load MAFFT/7.475-gompi-2020b-with-extensions


listOfData=$(cat /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/Tables/annot_table_all.csv | tail -n +2 | cut -f 2 | sort | uniq | grep intron)
PTH=(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/NOT_ALIGNED)
PTH_OUT=(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED)

for type in $listOfData;
do
FILELIST=$(ls $PTH/${type}/*.fasta)
for infile in $FILELIST;
do
  out_file=$(basename ${infile})
  mafft --nwildcard --auto --thread 20 ${infile} > ${PTH_OUT}/${type}/${out_file}
done
done
