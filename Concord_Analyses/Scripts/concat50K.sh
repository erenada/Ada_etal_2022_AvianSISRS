#!/bin/bash

#SBATCH --job-name="cat_50K_ch1"
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

#listOfData=$(cat ../Tables/annot_table_all.csv | tail -n +2 | cut -f 2 | sort | uniq)

PTH=(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/ALIGNED/ALL_50K)
PTH_OUT=(/data/schwartzlab/eren/Chapter2/CONTIGS/Annotation/CONCAT/ALL_50K)

# for type in $listOfData;
# do
#   mkdir ${PTH_OUT}/${type}
# done

cp /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/Scripts/AMAS_ch1.py ${PTH}/AMAS_ch1.py

cd ${PTH}

python3 AMAS_ch1.py concat -f fasta -d dna -i *fasta -c 20 --part-format raxml --concat-part ALL_50K_partition.txt --concat-out ALL_50K_concat.fasta

mv ALL_50K_concat.fasta ${PTH_OUT}/ALL_50K_concat.fasta
mv ALL_50K_partition.txt ${PTH_OUT}/ALL_50K_partition.txt
rm AMAS_ch1.py
