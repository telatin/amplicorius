#!/bin/bash
# 16s_diet analysis

# Set DBDIR somewhere

DB=$DBDIR/utax8_04.02.2020.fa
INPUT=../../datasets/16s_diet/
OUT=../../data_analysis/16s_diet/usearch
gunzip $INPUT/*.gz || true

set -euxo pipefail

usearch -fastq_mergepairs $INPUT/*R1*gz -relabel @ -fastqout $OUT/mrg.fq -fastq_maxdiffs 50 -fastq_pctid 80 -fastq_minmergelen 350  

usearch -fastq_filter $OUT/mrg.fq -relabel filt. -fastq_maxee 0.8 -fastq_minlen 300 -fastaout $OUT/filt.fa

usearch -otutab $OUT/mrg.fq -otus $OUT/asv.fa -threads 12 -otutabout $OUT/otutab.txt 

clustalo --outfmt=fa -i $OUT//asv.fa -o $OUT/asv.aln

usearch -sintax $OUT/asv.fa -db $DB -strand both -id 0.85 -tabbedout $OUT/asv.taxonomy.tsv   

fasttree  -nt -gtr -no2nd -spr 4 -quiet $OUT/asv.aln > $OUT/tree.tre
