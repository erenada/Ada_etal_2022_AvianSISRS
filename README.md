## "High levels of conflicting signal in genome-scale coding and non-coding loci support the early rapid cladogenesis hypothesis in Neoaves"


This repo contains the scripts and supplementary documents for Ada et al. 2022

Below, you can find a walkthrough for performed analyses.

### 1) DNA collection and generation of orthologous sequences

1.a) 

1.b) Running SISRS (Site Identification from Short Read Sequences

SISRS is a software to identify phylogenetically informative sites from next-generation whole-genome sequencing of multiple species. For more detailed information please visit the SISRS repo here: https://github.com/SchwartzLabURI/SISRS/ or see the Methods section in Ada et al. 2022 manuscript. Steps are briefly explained below for reproducibility purposes.

Please be aware that the scripts explained below should be run by a SLURM script which are located in SISRS/scripts/slurm_submissions/ directory. These SLURM scripts were prepared to be submitted to Andromeda cluster at University of Rhode Island system, so make sure you have modify necessary codes (directories, module loads etc.). The scripts will not run without installing and loading necessary modules/softwares.


 - First step to succesfully run SISRS software is to make sure that you have a correct directory structure. This can be done by running SISRS/scripts/sisrs_01_folder_setup.py script (scripts/slurm_submissions/1_submit.slurm) - This script will create a number of folders, including taxon folders in the RawReads, TrimReads, and SISRS_Run folders. In the 1_submit.slurm script, 1) you need to provide a path "-d" that contain folders of fastq.gz; 2) and the path for the output of your analysis "-dir" (which should be your main SISRS folder - for e.g: /home/eren/SISRS/)

 -  Then the raw reads 
