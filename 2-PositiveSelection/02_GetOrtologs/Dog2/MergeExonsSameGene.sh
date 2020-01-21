#! /bin/bash

#Daniel Chavez 2016

mkdir Intermidiate1

#Note use this script only if have previousrly edited your BED file
#To sucesfully edited your bed file do the follwing:
#1.Change the format from Biomart to bed format (do this with regula expresion)
#2.Use Beedtools to merge overlaping sequences (GATK Alternate reference fasta wont work properly without this step)
#3.Get sure that you have 1-based coordiantes, if not use the following:
#(awk -v FS='\t' '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$7"\t"$9"\t"$10}' input > output
#HINT(the regular expresion must match warethever is in your file)
#4.Use GATK AlternateReferenceFasta to extract CDS exons. 
#5.Replace the names of the GATK header output with those from the Bed file. To do this use the script called replaceNames_Fasta.py within the directory /data3/dechavezv/scripts/Python
#In the previous step you must be extreme carefull with the order. Be sure that the amount of lines of the bed file is the same as the number of '>' in the fast file.
#Also do tail to verify that the last line corespond to the last line in the bed file 

export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs

echo '############'
echo Linearizing fasta strings
echo '############'
for file in *.fa;do cat  $file | awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' > Linearized$file;done

echo '############'
echo erasing merged +\- strands # delete sequences that were merged and have a mixture of positive and negative strands
echo '############'
for file in Linearized*;do sed -i -r -e '/\+\,\-/{N;d;};/\-\,\+/{N;d;}' $file;done 

echo '############'
echo replacing "," for"_" This is necessary to have the proper header format for the merging exons step 
echo '############'
for file in  Linearized*; do sed -r 's/,\S+//g' $file  > Intermidiate1/Fixed_For_mergeExons$file;done

echo '############'
echo Mergin similar exons 
echo '############'
cd Intermidiate1 
for file in Fixed_For_mergeExons*; do python ../merge_CDS_Exons.py $file Out$file;done 

echo '############'
echo Reverse complement - strand
echo '############'
for file in Out*; do python ../ReverseComplemet_noChr_Pos.py $file ReverseStrand$file;done

#echo '############'
#echo Erase intermidiate files
#echo '############'
mv ReverseStrand*  ${Direc}/Dog${2}/Merge_File

rm *

cd ../../../

rm -rf Merged_Bam/
