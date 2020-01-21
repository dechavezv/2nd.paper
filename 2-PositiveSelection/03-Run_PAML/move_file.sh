#!/bin/bash

#for file in *.fasta; do /
#(ARTISTNAME=$(echo $file) && /
#MOVARTIST="/work/dechavezv/Pipeline/Beds/testing_GATK/PAML/Cleaned_Genomes/Transcripts/$file" && /
#MOVDESTINATION="/work/dechavezv/Pipeline/Beds/testing_GATK/PAML/Dir_$ARTISTNAME/" && /
#mv $MOVARTIST $MOVDESTINATION);done

for file in *.fasta; do /
(ARTISTNAME=$(echo $file) && /
for dir	in dir_*;do /
MOVARTIST="/u/home/d/dechavez/project-rwayne/PAML/Procesing/Cleaned_Genomes/Transcripts/$file" && /
MOVDESTINATION="/u/home/d/dechavez/project-rwayne/PAML/Procesing/$dir/Dir_$ARTISTNAME/" && /
mv $MOVARTIST $MOVDESTINATION; done) ;done

