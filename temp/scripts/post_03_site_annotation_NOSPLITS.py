#!/usr/bin/env python3

import os
from os import path
import sys
from glob import glob
import subprocess
import stat
from itertools import islice

script_dir = sys.path[0]
processors = str(int(sys.argv[1]))
ref_species = sys.argv[2]

site_id = 'SISRS_Biallelic_NoMissing'

#Set directories based off of script folder location
post_processing_dir = path.dirname(path.abspath(script_dir))+"/Post_SISRS_Processing"

if(not path.isdir(post_processing_dir+"/Annotations")):
    os.mkdir(post_processing_dir+"/Annotations")
annotation_dir = post_processing_dir+"/Annotations"

if(not path.isdir(annotation_dir+"/Composite")):
    os.mkdir(annotation_dir+"/Composite")
composite_annotation_dir = annotation_dir+"/Composite"

if(not path.isdir(annotation_dir+"/SISRS")):
    os.mkdir(annotation_dir+"/SISRS")
sisrs_annotation_dir = annotation_dir+"/SISRS"

ref_annotation_dir = path.dirname(path.abspath(script_dir))+"/Reference_Genome/Annotations"
ref_annotation_files = glob(ref_annotation_dir+"/*.bed")

#Sort annotation BED files
for annotationFile in ref_annotation_files:
    sort_annotation = ['sort',
            '-k',
            '1,1',
            '-k2,2n',
            annotationFile,
            '-o',
            annotationFile]
    os.system(' '.join(sort_annotation))

sisrs_site_dir = post_processing_dir+"/SISRS_Sites"
sisrs_sites = sisrs_site_dir+"/"+ref_species+"_"+site_id+"_NoGaps_LocList.txt"

sort_sisrs = ['sort',
    '-u',
    '-o',
    '{}'.format(sisrs_sites),
    sisrs_sites]
subprocess.call(sort_sisrs)

composite_site_dir = post_processing_dir+"/Whole_Genome_Mapping"

post_log_dir = post_processing_dir+"/logFiles"

composite_annos = []

with open(annotation_dir+"/Annotation_Counts.tsv","w") as count_file:
    with open(post_log_dir+'/out_05_Composite_Annotation',"w") as outfile:
        outfile.write("Composite Genome Annotation Counts:\n\n")
        for annotationFile in ref_annotation_files:
            annotation=path.basename(annotationFile).split('.')[0]
            output_anno ='{COMPOSITEANNODIR}/Composite_{ANNOTATION}_LocList.txt'.format(COMPOSITEANNODIR=composite_annotation_dir,ANNOTATION=annotation)
            bed_command=[
                'bedtools',
                'intersect',
                '-sorted',
                '-a',
                '{}'.format(annotationFile),
                '-b',
                '{}'.format(composite_site_dir+"/WholeGenome_"+ref_species+"_Mapped_NonDup.bed"),
                '-wb',
                '|',
                'awk',
                "'{print",
                '$NF',
                "}'",
                '|',
                'sort',
                '|'
                'uniq'
                '>',
                '{}'.format(output_anno)]
            os.system(' '.join(bed_command))
            print('Completed annotation transfer of '+annotation+' onto composite genome...')

            if(os.stat(output_anno).st_size == 0):
                count_file.write('Composite\tAll\tAll\t'+annotation+'\t0\n')
                outfile.write(annotation + " - No Sites\n")
            else:
                composite_annos.append(annotationFile)
                num_lines = sum(1 for line in open(output_anno))
                count_file.write('Composite\tAll\tAll\t'+annotation+'\t'+str(num_lines)+"\n")
                outfile.write(annotation + " - " + str(num_lines)+"\n")

sisrs_annos = []
with open(annotation_dir+"/Annotation_Counts.tsv","a+") as count_file:
    with open(post_log_dir+'/out_06_SISRS_Annotation',"w") as outfile:
        outfile.write("SISRS Annotation Counts:\n\n")
        for annotationFile in ref_annotation_files:
            annotation=path.basename(annotationFile).split('.')[0]
            input_anno ='{COMPOSITEANNODIR}/Composite_{ANNOTATION}_LocList.txt'.format(COMPOSITEANNODIR=composite_annotation_dir,ANNOTATION=annotation)
            output_anno ='{SISRSANNODIR}/SISRS_All_{ANNOTATION}_LocList.txt'.format(SISRSANNODIR=sisrs_annotation_dir,ANNOTATION=annotation)
            if(annotationFile in composite_annos):
                fetch_command = [
                    'comm',
                    '-12',
                    '{}'.format(input_anno),
                    '{}'.format(sisrs_sites),
                    '>',
                    '{}'.format(output_anno)]
                os.system(' '.join(fetch_command))
                if(os.stat(output_anno).st_size == 0):
                    count_file.write('SISRS\tAll\tAll\t'+annotation+'\t0\n')
                    outfile.write(annotation + " - No Sites\n")
                else:
                    sisrs_annos.append(annotationFile)
                    num_lines = sum(1 for line in open(output_anno))
                    count_file.write('SISRS\tAll\tAll\t'+annotation+'\t'+str(num_lines)+"\n")
                    outfile.write(annotation + " - " + str(num_lines)+"\n")
            else:
                count_file.write('SISRS\tAll\tAll\t'+annotation+'\t0\n')
                outfile.write(annotation + " - No Sites\n")

with open(annotation_dir+"/Annotation_Counts.tsv","a+") as count_file:
    for annotationFile in ref_annotation_files:
        annotation=path.basename(annotationFile).split('.')[0]
        ref_count_command = [
            'bedtools',
            'merge',
            '-i',
            '{}'.format(annotationFile),
            '|',
            'awk',
            "'{SUM",
            '+=',
            '$3-$2}',
            'END',
            '{print',
            "SUM}'",
            '-']
        ref_count = subprocess.check_output(' '.join(ref_count_command),shell=True).decode().strip()
        count_file.write('Reference\tAll\tAll\t'+annotation+'\t'+str(ref_count)+"\n")

