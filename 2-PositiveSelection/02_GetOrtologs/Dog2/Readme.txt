#Before you run this script make sure you have the following:
## - One folder called backup.beds with bedfiles split into sevetn difernt files (e.g Canis_familiaris_1.bed)
## - Your genome in fasta format. This genomes was generated in the previous step '01_fromBamTofasta' 
## - the necesary scripts: Extract_Exons_3.sh, merge_CDS_Exons.py, MergeExonsSameGene.sh, replaceNames_Fasta.py, ReverseComplemet_noChr_Pos.py and submit_exon_Extraction.sh 

#To run the pipiline just type the following
qsub submit_exon_Extraction.sh

# The main script is Extract_Exons_3.sh and it takes two arguments
# Extract_Exons_3.sh a b
# a=the number of Directory from the sevent in total. For instance, DirCanis_familiaris_1.bed will be: Extract_Exons_3.sh a=1
# b=The main Directory containing a particular genome. For instance, Dog2 will be Extract_Exons_3.sh a=1 b=2
# If you want to do multiple genomes at the same time you need to cp Dog2 and replace the exting genomes *.fa  with the new genome
# for instance cp -r Dog2 Dog3; cd Dog3; rm *.fa; cp ~/Genomes/your-genome-in.fasta.fa ./


#Change the paths 
#The script is configurated to be runed in our server in hoffman. 
#You must change the path within the script `Extract_Exons_3.sh` and `MergeExonsSameGene.sh` if working from a diferent directory. 

# Define your Genome
Make sure to specified your genome by changin this line within the Extract_Exons_3.sh script:
#export Fasta=<your-path>/Dog${2}/<Your-genome>.fa

# finally concatenate all genes into a single file and put it in the corret folder in data/
# cat Merge_File/* > /u/home/d/dechavez/project-rwayne/2nd.paper/data/Genomes.canids.Jan.2020.Ortologs.fasta/<All.my.Ortologs>.fa

#Then remove individual files
#rm -rf Merge_File
