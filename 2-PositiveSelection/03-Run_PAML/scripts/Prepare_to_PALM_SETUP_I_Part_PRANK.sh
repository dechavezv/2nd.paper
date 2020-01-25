#! /bin/bash
#$ -l highp,h_rt=10:00:00,h_data=5G
#$ -pe shared 1
#$ -N IpartPAML
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML_I.out
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML_I.err
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

export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML
export Genome=/u/home/d/dechavez/project-rwayne/2nd.paper/data/Genomes.canids.Jan.2020.Ortologs.fasta
export Vespa=/u/home/d/dechavez/VESPA-1.0/vespa.py

cd ${Direc}

#mkdir Genomes

#echo '############'
#echo Fix_format_Biomart_seq_into_PipelineFormat
#echo '############'

#cp ${Genome}/* ./Genomes

#cd Genomes
#for file in *.fa; do
#sed -i 's/\t/\|/'g $file;done
#rm *.fai

#cd ..

echo '############'
echo Clean sequence
echo '############'
python ${Vespa} ensembl_clean -input=Genomes/ -label_filename=True

echo '############'
echo Translate sequence  
echo '############'
python ${Vespa} translate -input=Cleaned_Genomes/

echo '############'
echo Create database
echo '############'
python ${Vespa} create_database -input=Translated_Cleaned_Genomes/

echo '############'
echo Move Files
echo '############'
mkdir Procesing
cp -r scripts/tree/ Procesing/
cp scripts/Prepare_to_PALM_SETUP_II_part.sh Procesing/
cp -r scripts/CodemlWrapper/ Procesing/
cp scripts/codeml Procesing/
cp scripts/fasta2phylip.pl Procesing/
cp scripts/tree.txt Procesing/
cp scripts/prank Procesing/
cp scripts/muscle3.8.31_i86linux64 Procesing/
cp scripts/fasta2phylip.pl Procesing/
cp scripts/GenerateCodemlWorkspace.pl Procesing/
cp database.fas Procesing/
cp scripts/PAML_aling_PRANK.sh Procesing/
cp -r Cleaned_Genomes/ Procesing/
cp scripts/move_file.sh Procesing/

cd Procesing/

echo '############'
echo Split by gene ID
echo '############'
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
cp codeml $dir
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
cp codeml Dir_$file && /
mv $file Dir_$file && /
cp muscle3.8.31_i86linux64 Dir_$file && /
cp fasta2phylip.pl Dir_$file && /
cp prank Dir_$file && /
cp GenerateCodemlWorkspace.pl Dir_$file);done && /
);done
