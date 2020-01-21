#! /bin/bash
#$ -l highp,h_rt=10:00:00,h_data=5G
#$ -pe shared 1
#$ -N four_HD_Indel_PAML_I
#$ -cwd
#$ -m bea
#$ -o ./four_HD_Indels_PAML_I.out
#$ -e ./four_HD_Indels_PAML_I.err
#$ -M dechavezv

echo Author:Daniel Chavez Year:2016 
 
#this script take the ectracted exons obtained from the previous scripts (Extract_Exons.sh and MergeExonsSameGene.sh)/
#the CDS fasta file has to be '|' delimited. Also the first field in the header (before the first '|'),/
#must be Ensembl gene ID, and the second Ensembl transcript ID /
#the name of fasta files must match the name in the tips of the tree but without the files extension

#The purpose of this script are the following:/
#Clean CDS exons with lengths no-divisible by three
#Clean sequence with internal stop codons
#keep the longest transcript
#Translates nucleotide sequences that passed the QC filter into amino acid sequences in the first reading frame forward only    
#Protein mulitple sequene alingment guided nucleotide: this has two advantages in opose to work directly with nucletides:
#1.each column within the protein MSA represents aligned codons and therefore avoids aligning incomplete codons or frame- shift mutations
#2.protein MSAs represent a comparison of the phenotype-producing elements of protein-coding sequences
#And sets the enviroment for the positive selection analysis within Paml

#Files requiered for the script to work properly:
#1. directory with name Genomes/ containing all the fasta files (CDS Exons) of the species that will be included in positive selection test
#2. The spescies tree ("tree.txt")
#3. Muscle sequence alingment executable file ("muscle3.8.31_i86linux64")
#4. Script that converts alingment into phylip format ("fasta2phylip.pl")
#5. Script that sets the enviroment for Paml ("GenerateCodemlWorkspace.pl")
#6. excecutable file COEDML ("codeml")  
#7. keep_orthologos.sh

. /u/local/Modules/default/init/modules.sh
module load python/2.7.3
module load perl/5.10.1
export PERL5LIB=$HOME/VESPA-1.0:$PERL5LIB


mkdir PAML_out #create empty file where outouts will be located at

echo '############'
echo Fix_format_Biomart_seq_into_PipelineFormat
echo '############'

#cd Genomes/
#for file in *.fa; do
#sed -i 's/\t/\|/'g $file;done
#cd ..

#cp Dog.fa Genomes/

echo '############'
echo Clean sequence
echo '############'
python /u/home/d/dechavez/VESPA-1.0/vespa.py ensembl_clean -input=Genomes/ -label_filename=True

echo '############'
echo Translate sequence  
echo '############'
python /u/home/d/dechavez/VESPA-1.0/vespa.py translate -input=Cleaned_Genomes/

echo '############'
echo Create database
echo '############'
python /u/home/d/dechavez/VESPA-1.0/vespa.py create_database -input=Translated_Cleaned_Genomes/

echo '############'
echo Move Files
echo '############'
mkdir Procesing
cp -r tree/ Procesing/
cp Prepare_to_PALM_SETUP_II_part.sh Procesing/
cp -r CodemlWrapper/ Procesing/
cp fasta2phylip.pl Procesing/
cp tree.txt Procesing/
cp prank Procesing/
cp muscle3.8.31_i86linux64 Procesing/
cp fasta2phylip.pl Procesing/
cp GenerateCodemlWorkspace.pl Procesing/
cp database.fas Procesing/
cp PAML_aling_PRANK.sh Procesing/
cp -r Cleaned_Genomes/ Procesing/
cp move_file.sh Procesing/

echo '############'
echo Split by gene ID
echo '############'
cd Procesing/
awk -F '|' '/^>/ {F=sprintf("%s.fasta",$2); print > F;next;} {print >> F;}' database.fas
i=0; for f in *.fasta; do d=dir_$(printf %03d $((i/500+1))); mkdir -p $d; mv "$f" $d; let i++; done

echo '############'
echo Move Files
echo '############'
for dir in dir*; do
cp -r tree/ $dir
cp Prepare_to_PALM_SETUP_II_part.sh $dir 
cp -r CodemlWrapper/ $dir
cp fasta2phylip.pl $dir 
cp tree.txt $dir 
cp PAML_aling_PRANK.sh $dir
cp muscle3.8.31_i86linux64 $dir 
cp fasta2phylip.pl $dir
cp prank $dir
cp GenerateCodemlWorkspace.pl $dir;done

echo '############'
echo Move_Files
echo '############'
for dir in dir*; do (cd $dir && /
for file in *.fasta; do /
(mkdir Dir_$file && /
cp -r tree/ Dir_$file && /
cp -r CodemlWrapper/ Dir_$file && /
cp fasta2phylip.pl Dir_$file && /
cp tree.txt Dir_$file && /
mv $file Dir_$file && /
cp muscle3.8.31_i86linux64 Dir_$file && /
cp fasta2phylip.pl Dir_$file && /
cp prank Dir_$file && /
cp GenerateCodemlWorkspace.pl Dir_$file);done && /
);done

