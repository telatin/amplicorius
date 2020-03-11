#!/bin/fish

cat list | perl -ne 'while ($_=~/(ftp.*?gz)/g) { print "$1\n"; }'  | grep run |sort | uniq | xargs wget
for i in V*; mv $i (echo $i|cut -f1 -d.|sed 's/V//g')x(echo $i|cut -f2 -d.)x(echo $i|cut -f3 -d.|sed 's/-/_/').fastq.gz; end
