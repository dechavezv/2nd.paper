#! /bin/bash
#$ -l highp,h_rt=2:00:00,h_data=1G
#$ -pe shared 1
#$ -N Indel_PAML_I
#$ -cwd
#$ -m bea
#$ -o ./Indels_PAML_I.out
#$ -e ./Indels_PAML_I.err
#$ -M dechavezv

echo '############'
echo Move_Transcript
echo '############'
cd Procesing/
cp move_file.sh Cleaned_Genomes/
cd Cleaned_Genomes
mkdir Transcripts
cat *.fa  > Transcripts/database_dna.fas
cp move_file.sh Transcripts
cd Transcripts
awk -F '|' '/^>/ {F=sprintf("%s.fasta",$2); print > F;next;} {print >> F;}' database_dna.fas
rm database_dna.fas
bash move_file.sh
