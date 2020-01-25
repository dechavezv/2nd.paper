#! /bin/bash
#$ -l highp,h_rt=2:00:00,h_data=1G
#$ -pe shared 1
#$ -N AminoToNucle
#$ -cwd
#$ -m bea
#$ -o ./Indels_PAML_I.out
#$ -e ./Indels_PAML_I.err
#$ -M dechavezv

DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML

echo '############'
echo Move_Transcript
echo '############'

cd ${DIREC}/Procesing
cp move_file.sh Cleaned_Genomes/
cd Cleaned_Genomes
mkdir Transcripts
cat *.fa  > Transcripts/database_dna.fas
cp move_file.sh Transcripts
cd Transcripts
awk -F '|' '/^>/ {F=sprintf("%s.fasta",$2); print > F;next;} {print >> F;}' database_dna.fas
rm database_dna.fas
bash move_file.sh
