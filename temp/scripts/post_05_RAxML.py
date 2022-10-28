#!/usr/bin/env python3

import os
from os import path
import sys
from glob import glob
import pandas as pd
import subprocess
from subprocess import check_call

script_dir = sys.path[0]
processors = str(int(sys.argv[1]))
ref_species = sys.argv[2]

site_id = 'SISRS_Biallelic_NoMissing'

sisrs_dir = path.dirname(path.abspath(script_dir))+"/SISRS_Run"
annotation_dir = path.dirname(path.abspath(script_dir))+"/Post_SISRS_Processing/Annotations/SISRS"

if(not path.isdir(annotation_dir+"/Alignments")):
    os.mkdir(annotation_dir+"/Alignments")
alignment_dir = annotation_dir+"/Alignments"

if(not path.isdir(alignment_dir+"/RAxML")):
    os.mkdir(alignment_dir+"/RAxML")
raxml_dir = alignment_dir+"/RAxML"

list_link_command = [
    'ln',
    '{}/SISRS_All_*'.format(annotation_dir),
    '{}'.format(alignment_dir)]

os.system(' '.join(list_link_command))

annotation_loclist_files = glob(alignment_dir+"/*_LocList.txt")

for annotationFile in annotation_loclist_files:
    annotation=os.path.basename(annotationFile.replace('SISRS_All_','').replace('_LocList.txt',''))
    anno_alignment = ['python',
        '{}/alignment_slicer.py'.format(script_dir),
        '{}/alignment_bi_locs_m0.txt'.format(sisrs_dir),
        '{}'.format(annotationFile),
        '{}/alignment_bi_m0.phylip-relaxed'.format(sisrs_dir),
        ref_species+"_"+site_id+"_"+annotation,
        alignment_dir]
    subprocess.call(anno_alignment)

loclists = glob(alignment_dir+"/*_LocList.txt")
for loclist in loclists:
    os.remove(loclist)

sisrs_link_command = [
    'ln',
    '{}/alignment_bi_m0_nogap.phylip-relaxed'.format(sisrs_dir),
    '{}'.format(alignment_dir)]
os.system(' '.join(sisrs_link_command))

alignment_list = glob(alignment_dir+"/*.phylip-relaxed")

with open(raxml_dir+"/RAxML_Script.sh","w") as raxscript:
    raxscript.write("#!/bin/sh\n")
    for alignment in alignment_list:
        if "alignment_bi_m0_nogap.phylip-relaxed" in alignment:
            annotation="AllSISRS"
        else:
            annotation=os.path.basename(alignment.replace(ref_species+"_"+site_id+"_",'').replace('_NoGaps.phylip-relaxed',''))
        raxml_command = [
            'raxmlHPC-PTHREADS-SSE3',
            '-s',
             '{}'.format(alignment),
             '-n',
             '{}'.format(ref_species+"_"+site_id+"_"+annotation),
             '-m',
             'ASC_GTRGAMMA',
             '--asc-corr=lewis',
             '-T',
             '{}'.format(processors),
             '-f',
             'a',
             '-p',
             '{}'.format("$RANDOM"),
             '-N',
             'autoMRE',
             '-x',
             '{}'.format("$RANDOM")]
        raxscript.write(' '.join(raxml_command)+";\n")

os.chdir(raxml_dir)
subprocess.Popen(['bash',"RAxML_Script.sh"])
