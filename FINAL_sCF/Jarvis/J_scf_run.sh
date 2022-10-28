#!/bin/bash
#SBATCH --job-name="J-scfRun"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_J-scfRun"
#SBATCH --error="err_J-scfRun"
#SBATCH --exclusive

#SBATCH --mail-type=END,FAIL
#
cd $SLURM_SUBMIT_DIR

#Yana's modules below:

module purge
module load IQ-TREE/1.7-beta16-foss-2018b

#!/bin/bash
#SBATCH --job-name="J-scfRun"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_J-scfRun"
#SBATCH --error="err_J-scfRun"
#SBATCH --exclusive

#SBATCH --mail-type=END,FAIL
#
cd $SLURM_SUBMIT_DIR

#Yana's modules below:

module purge
module load IQ-TREE/1.7-beta16-foss-2018b

#!/bin/bash
#SBATCH --job-name="J-scfRun"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_J-scfRun"
#SBATCH --error="err_J-scfRun"
#SBATCH --exclusive

#SBATCH --mail-type=END,FAIL
#
cd $SLURM_SUBMIT_DIR

#Yana's modules below:

module purge
module load IQ-TREE/1.7-beta16-foss-2018b

#!/bin/bash
#SBATCH --job-name="J-scfRun"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_J-scfRun"
#SBATCH --error="err_J-scfRun"
#SBATCH --exclusive

#SBATCH --mail-type=END,FAIL
#
cd $SLURM_SUBMIT_DIR

#Yana's modules below:

module purge
module load IQ-TREE/1.7-beta16-foss-2018b

iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_CDS_NoGaps.phylip-relaxed --scf 100 --prefix J-CDS-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_five_prime_UTR_NoGaps.phylip-relaxed --scf 100 --prefix J-5UTR-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_gene_NoGaps.phylip-relaxed --scf 100 --prefix J-GENE-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_genic_other_NoGaps.phylip-relaxed --scf 100 --prefix J-GENICOTHER-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_intergenic_NoGaps.phylip-relaxed --scf 100 --prefix J-INTERGENIC-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_intron_NoGaps.phylip-relaxed --scf 100 --prefix J-INTRON-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_lnc_RNA_NoGaps.phylip-relaxed --scf 100 --prefix J-LNC-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_pseudogene_NoGaps.phylip-relaxed --scf 100 --prefix J-PSEUDOGENE-scf
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_smRNA_NoGaps.phylip-relaxed --scf 100 --prefix J-smRNA-scf 
iqtree-mpi -t ./Reference_Trees/JarvisFinalTree.nwk -s Alignments/Biallelic_5Mising_three_prime_UTR_NoGaps.phylip-relaxed --scf 100 --prefix J-3UTR-scf 
