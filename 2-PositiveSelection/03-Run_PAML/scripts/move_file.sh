#!/bin/bash

#for file in *.fasta; do /
#(ARTISTNAME=$(echo $file) && /
#MOVARTIST="/work/dechavezv/Pipeline/Beds/testing_GATK/PAML/Cleaned_Genomes/Transcripts/$file" && /
#MOVDESTINATION="/work/dechavezv/Pipeline/Beds/testing_GATK/PAML/Dir_$ARTISTNAME/" && /
#mv $MOVARTIST $MOVDESTINATION);done

for file in *.fasta; do /
(ARTISTNAME=$(echo $file) && /
for dir	in dir_*;do /
MOVARTIST="/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/Procesing/Cleaned_Genomes/Transcripts/$file" && /
MOVDESTINATION="/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/Procesing/$dir/Dir_$ARTISTNAME/" && /
mv $MOVARTIST $MOVDESTINATION; done) ;done
