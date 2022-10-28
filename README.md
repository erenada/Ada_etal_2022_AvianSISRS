## "High levels of conflicting signal in genome-scale coding and non-coding loci support the early rapid cladogenesis hypothesis in Neoaves"


This repo contains the scripts and supplementary documents for Ada et al. 2022

Below, you can find a walkthrough for performed analyses.

### 1) DNA collection and generation of orthologous sequences

1.a)

1.b) Running SISRS (Site Identification from Short Read Sequences

SISRS is a software to identify phylogenetically informative sites from next-generation whole-genome sequencing of multiple species. For more detailed information please visit the SISRS repo here: https://github.com/SchwartzLabURI/SISRS/ or see the Methods section in Ada et al. 2022 manuscript. Steps are briefly explained below for reproducibility purposes.

Please be aware that the scripts explained below should be run by a SLURM script which are located in SISRS/scripts/slurm_submissions/ directory. These SLURM scripts were prepared to be submitted to Andromeda cluster at University of Rhode Island system, so make sure you have modify necessary codes (directories, module loads etc.). The scripts will not run without installing and loading necessary modules/softwares.


 - First step to succesfully run SISRS software is to make sure that you have a correct directory structure. This can be done by running SISRS/scripts/sisrs_01_folder_setup.py script (scripts/slurm_submissions/1_submit.slurm) - This script will create a number of folders, including taxon folders in the RawReads, TrimReads, and SISRS_Run folders. In the 1_submit.slurm script, 1) you need to provide a path "-d" that contain folders of fastq.gz; 2) and the path for the output of your analysis "-dir" (which should be your main SISRS folder - for e.g: /home/eren/SISRS/)

 -  Then the raw reads needs to be quality-checked and trimmed. This can be done by running  sisrs_02_read_trimmer.py* script. This script will run FastQC and save the ouptut files in a seperate folder. Script will also run bbduk software to trim adapters.

 - In next step, trimmed + quality-checked reads were subsetted for composite genome assembly. Here, sisrs_03_read_subsetter.py* script requires a value that is an approximate size of your genome as an input. In our analyses, we specified this value to 1 Gbp assuming the size of an average bird genome (ranges from ~0.8Gbp to ~1.2Gbp). The script
will subset each taxons reads down to (10*Y)/X bases (~10X total coverage when summed).

 - Step 4, We run Ray software to assembly a composite genome and Bowtie2 and Samtools for genome indexing (sisrs_04_ray_composite.py).

    - Statistics for assembled genome can be found here:

 - Step 5 script prepares the data for SISRS run by setting up correct directories and preparing the contig files for the run (sisrs_05_setup_sisrs.py).

 - Next, we run the step 6 script to align data from a single taxon to the composite genome (sisrs_06_align.py).

  - Step 6b pileups from the Bowtie2 alignment and creates a species-specific genome by replacing the variable sites. Also index the new genome (sisrs_06b_pileup.py).

  - Step 6c outputs a sorted bam by aligning reads to the contigs.fa file for each species (sisrs_06c_align2.py).

  - Step 6d creates a pileup for the contigs from species-specific genome then calls a base for each site (sisrs_06d_pileup2.py)

  - Finally, script sisrs_07_output_sisrs.py outputs these sites as final alignments as well as their location on contigs (SISRS final alignments include: biallelic informative sites with gaps allowed and not allowed, all informative sites with gaps allowed and not allowed). Here you must provide the "-m" flag as desired number of missing species allowed for a site in the final alignments. Here we allowed 5 missing species for a given site.

  - Step 7a (sisrs_07_a_contigs_processing.py) & 7b (sisrs_07_b_contigs_alignment.py) processes and align the output contig fasta files.

  ## Post-SISRS:

After completing the SISRS run, we annotated the aligned contigs using a set of custom Python scripts (annotation_bed2table.py,  annotation_blast_parser.py, annotation_getTaxContigs.py). HOWEVER, note that in this step, you should be ONLY runnig the "annotation_alx_ch1.sh" script which calls the scripts mentioned above). All the scripts should be in the same folder and can be found here: /CONTIGS/Annotation/Scripts.
