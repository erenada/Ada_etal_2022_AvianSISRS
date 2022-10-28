
#!/bin/sh
bowtie2 -p 20 -x /data/schwartzlab/bob/bird_SISRS/Reference_Genome/Ens98_GalGal -f -U /data/schwartzlab/bob/bird_SISRS/SISRS_Run/GalGal/contigs.fa | samtools view -Su -@ 20 -F 4 - | samtools sort -@ 20 - -o /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal_Temp.bam

samtools view -@ 20 -H /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal_Temp.bam > /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal_Header.sam

samtools view -@ 20 /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal_Temp.bam | grep -v "XS:" | cat /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal_Header.sam - | samtools view -@ 20 -b - > /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal.bam

rm /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/*Temp.bam
rm /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/*Header.sam

samtools view /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal.bam | awk 'BEGIN {OFS = "	"} { print $1, $3, $4, $2, $6}' > /data/schwartzlab/bob/bird_SISRS/Post_SISRS_Processing/GalGal_MapData.tsv

