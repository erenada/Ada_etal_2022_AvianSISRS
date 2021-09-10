#!/bin/bash

#SBATCH --job-name="cat_subsets"
#SBATCH --time=100:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # CHANGE THIS to the number of processors on your node
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your email address
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err
#SBATCH --exclusive

cd $SLURM_SUBMIT_DIR

module purge

#CHANGE THESE IF NOT ON A URI SYSTEM

module load Python/3.7.4-GCCcore-8.3.0

listOfData=$(cat ../Tables/annot_table_all.csv | tail -n +2 | cut -f 2 | sort | uniq)

PTH=(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED)
PTH_OUT=(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/CONCAT)


for type in $listOfData;
do
  mkdir ${PTH_OUT}/${type}
  cp /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/Scripts/AMAS_ch1.py ${PTH}/${type}
  python3 ${PTH}/${type}/AMAS.py concat -f fasta -d dna -i *fasta -c 20
  rm ${PTH}/${type}/AMAS.py
  mv ${PTH}/${type}/concatenated.out ${PTH_OUT}/${type}/"${type}"_concatenated.fasta
  mv ${PTH}/${type}/partitions.txt ${PTH_OUT}/${type}/"${type}"_partitions.txt
done
