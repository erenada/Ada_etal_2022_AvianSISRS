#!/bin/bash

#sorting the contigs by the number of SISRS sites they contain and copy to given directory


# sort

#cut -d'/' -f 1 alignment_locs_m0_nogap.txt | uniq -c | sort -bgr | sed 's/[[:space:]]//' > M_0_sorted_frequencies.csv

#cut -d'/' -f 1 alignment_locs_m5_nogap.txt | uniq -c | sort -bgr | sed 's/[[:space:]]//' > M_5_sorted_frequencies.csv

# copy

for contig in $(cut -d'/' -f 1 /data/schwartzlab/eren/Alignments/Ch_1_alignments/alignments_0821/alignment_locs_m5_nogap.txt | uniq -c | sort -bgr | sed 's/[[:space:]]*[[:digit:]]*[[:space:]]//' | head -50000);
do
  cp /data/schwartzlab/eren/Chapter1/CONTIGS/contigs_outputs/$contig.fasta /data/schwartzlab/eren/Chapter1/SISRS_Run/contigs_outputs
done
