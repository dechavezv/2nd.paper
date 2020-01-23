#! /bin/bash

echo '############'
echo Move_Transcript
echo '############'

cp move_file.sh Cleaned_Genomes/
cd Cleaned_Genomes
mkdir Transcripts
cat *.fa  > Transcripts/database_dna.fas
cp move_file.sh Transcripts
cd Transcripts
awk -F '|' '/^>/ {F=sprintf("%s.fasta",$2); print > F;next;} {print >> F;}' database_dna.fas
rm database_dna.fas
bash move_file.sh











