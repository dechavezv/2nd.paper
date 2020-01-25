#!/bin/bash

export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML

for file in *.fasta; do /
(ARTISTNAME=$(echo $file) && /
for dir	in dir_*;do /
MOVARTIST="${Direc}/Procesing/Cleaned_Genomes/Transcripts/$file" && /
MOVDESTINATION="${Direc}/Procesing/$dir/Dir_$ARTISTNAME/" && /
mv $MOVARTIST $MOVDESTINATION; done) ;done
