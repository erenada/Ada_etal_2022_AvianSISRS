#!/bin/bash
#SBATCH --job-name="getCF"
#SBATCH --time=170:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # CHANGE THIS to processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your user email address
#SBATCH --mail-type=END,FAIL
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err
#SBATCH --exclusive

#get started here

## Calculating gene/locus trees

module purge

module purge

module load GCC/9.3.0
module load GCCcore/9.3.0
module load OpenMPI/4.0.3-GCC-9.3.0

#module load IQ-TREE/2.1.2-foss-2020a

REF_TREE=/data/schwartzlab/eren/Chapter1/Concord_Analyses/ReferenceTrees/Cladograms

ALN_DIR=/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/CONCAT

LOC_TREES=/data/schwartzlab/eren/Chapter1/Concord_Analyses/LocusTrees

cd $ALN_DIR

for tree in $(ls $REF_TREE);
do
  for type in $(ls -d */ | sed -e "s/\///g");
  do
    /data/schwartzlab/eren/programs/iqtree-2.1.3-Linux/bin/iqtree2 -t ${REF_TREE}/${tree} --gcf ${LOC_TREES}/${type}_loci.treefile -s ${ALN_DIR}/${type}/${type}_concat.fasta --scf 100 --prefix ${tree}_${type}_concord -nt 20
done
done
