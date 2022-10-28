#!/bin/bash

file="$1"

for i in {1..48}

do
  read line
  mkdir /data/schwartzlab/eren/Bird_SISRS/QCReports/"${line}"
  cp /data/schwartzlab/Trimmed_SISRS/Birds/fastQC/HTML/"${line}"*html /data/schwartzlab/eren/Bird_SISRS/QCReports/${line}
done < "$1"
