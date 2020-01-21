# Before you run this script make sure you have the following:

## - One folder called bedFiles with bedfiles split into sevetn difernt files (e.g Canis_familiaris_1.bed) 
## - the necesary scripts: Extract_Exons_3.sh, merge_CDS_Exons.py, MergeExonsSameGene.sh, replaceNames_Fasta.py, ReverseComplemet_noChr_Pos.py and submit_exon_Extraction.sh 

#To run the pipiline just type the following
qsub submit_exon_Extraction.sh

# The main script is Extract_Exons_3.sh and it takes two arguments
# Extract_Exons_3.sh a b
# a=the number of Directory from the sevent in total. For instance, DirCanis_familiaris_1.bed will be: Extract_Exons_3.sh a=1
# b=The name of the genome





#If you wnat to run in other computer Change the paths 
#The script is configurated to be runed in our server in hoffman. 
#You must change the path within the script `Extract_Exons_3.sh` and `MergeExonsSameGene.sh` if working from a diferent directory. 
#Tou have to replace the following line with your own path
# export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs
# export Direc=<your.path.goes.here>

# finally concatenate all genes into a single file and put it in the corret folder in data/
# cat Merge_File/* > /u/home/d/dechavez/project-rwayne/2nd.paper/data/Genomes.canids.Jan.2020.Ortologs.fasta/<All.my.Ortologs>.fa

#Then remove individual files
#rm -rf Merge_File
