#! /bin/bash

#$ -l highp,h_rt=10:00:00,h_data=1G
#$ -pe shared 1
#$ -N OrtoFasta_BD
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/Dog${2}/DirCanis_familiaris_${1}.bed/log/OrtoFasta_BD.out
#$ -e /u/home/d/dechavez/project-rwayne/Dog${2}/DirCanis_familiaris_${1}.bed/log/OrtoFasta_BD.err
#$ -M dechavezv

#highmem

#Before using this script be sure to split your Bedfile into multiple files 
#saved them in diferent folders (e.g Dir_1, Dir_2,etc) then called this script from each folder independently 

# Make sure you have your genome in fasta format

#This script will edit the Bed file downloaded from Biomart in order to be used in downstream analysis

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load gatk/3.1.1
module load java/1.7.0_45
module load bedtools

#create directory for analysis
mkdir -p DirCanis_familiaris_$1.bed

#create directory for output files
mkdir Merge_File

 
# change directory
cd DirCanis_familiaris_$1.bed

# copy bed file to current dierctory
cp ../backup.beds/Canis_familiaris_$1.bed ./


#Separate files by trnascript

awk -v FS='\t' '{print > $4 $5 $6}' Canis_familiaris_$1.bed
for file in ENSCAFG*; do mv $file $file.bed;done
rm Canis_familiaris_$1.bed


#First lets create an empty folder called Merged_Bam
mkdir Merged_Bam/ 

#Define the path where files will be directed
export OUTMerge=/u/home/d/dechavez/project-rwayne/Dog${2}/DirCanis_familiaris_$1.bed/Merged_Bam

#copy all files and scripts in "Merged_Bam" directory
cp ../replaceNames_Fasta.py Merged_Bam/
cp ../MergeExonsSameGene.sh Merged_Bam/
cp ../merge_CDS_Exons.py Merged_Bam/
cp ../ReverseComplemet_noChr_Pos.py Merged_Bam/

#Merge overlaping coordinates 
for file in *.bed;do bedtools merge -i $file -c 4,5,6,7,8,9,10 -o collapse > ${OUTMerge}/Merged_$file; done

#remove intermidate files
rm ENSCAFG*

#go into the directory 
cd ${OUTMerge}/

#Do alternate Reference fasta for each bed file idependently
#The computational time for each bed file is ~4 minutes per file

for file in *.bed;do

echo '#########'
echo 'MakingDirectories_&&_MovingFiles'
echo '#########'

mkdir Dir_$file/
cp $file Dir_$file/
cp replaceNames_Fasta.py Dir_$file/
cp MergeExonsSameGene.sh Dir_$file/
cp merge_CDS_Exons.py Dir_$file/
cp ReverseComplemet_noChr_Pos.py Dir_$file/

echo '#########'
echo 'Bedtools_Fasta'
echo '#########'

export Fasta=/u/home/d/dechavez/project-rwayne/Dog${2}/red.fox.fa
export REFEREN=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export neutral=$file
export OUT=Dir_$file

bedtools getfasta -fi ${Fasta} -bed ${neutral} -fo ${OUT}/$file.fa \
;done

echo '#########'
echo 'Designating_Names'
echo '#########'
#replace header names of previous outputs with header of bed files 

rm *.bed
for dir in /u/home/d/dechavez/project-rwayne/Dog${2}/DirCanis_familiaris_$1.bed/Merged_Bam/*.bed/; do (cd "$dir" && python replaceNames_Fasta.py *.fa *.bed Name_ && \
rm Merged_*);done


echo '#########'
echo 'Preparing sequence to VESPA Pipieline'
echo '#########'

for dir in /u/home/d/dechavez/project-rwayne/Dog${2}/DirCanis_familiaris_$1.bed/Merged_Bam/*.bed/; do (cd "$dir" && \
bash MergeExonsSameGene.sh $1 $2);done
