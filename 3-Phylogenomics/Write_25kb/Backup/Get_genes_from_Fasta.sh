#! /bin/bash

#Daniel Chavez 2016

#Note use this script only if have previousrly edited your BED file
#To sucesfully edited your bed file do the follwing:
#1.Change the format from Biomart to bed format (do this with regula expresion)
#2.Use Beedtools to merge overlaping sequences (GATK Alternate reference fasta wont work properly without this step)
#3.Get sure that you have 1-based coordiantes, if not use the following:
#(awk -v FS='\t' '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$7"\t"$9"\t"$10}' input > output
#HINT(the regular expresion must match warethever is in your file)
#4.Make sure that the header of your fasta file has three colums separated by '-' for example: chr01-122-12344
#Do tail to verify that the last line corespond to the last line in the bed file 


# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools/1.2
module load samtools/1.2
module load bedtools/2.26.0


mkdir Merge_File
echo '#########'
echo 'Designating_Names'
echo '#########'
#replace header names of previous outputs with header of bed files
for file in *.fa; do (python replaceNames_Fasta_V2.py $file *.bed Name_$file);done

echo '############'
echo erasing merged +\- strands # delete sequences that were merged and have a mixture of positive and negative strands
echo '############'
for file in Name*;do sed -i -r -e '/\+\,\-/{N;d;};/\-\,\+/{N;d;}' $file;done 

echo '############'
echo replacing "," for"_" This is necessary to have the proper header format for the merging exons step 
echo '############'
for file in  Name*; do sed -r 's/,\S+//g' $file  > Fixed_For_mergeExons$file;done

echo '############'
echo Mergin similar exons 
echo '############'
for file in Fixed_For_mergeExons*; do python merge_CDS_Exons.py $file Out$file;done 

echo '############'
echo Reverse complement - strand
echo '############'
for file in Out*; do python ReverseComplemet_noChr_Pos.py $file ReverseStrand$file;done

#echo '############'
#echo Erase intermidiate files
#echo '############'

mv ReverseStrand* Merge_File

rm Fixed_For_mergeExons*
rm Name*
rm Out* 
