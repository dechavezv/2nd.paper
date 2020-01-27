This pipeline works with sequences that were alredy anayzed in PAML

make sure that all the seuquences have all 13 species you can you use the script 'remove_incomplete_Sequences_v2.py' to do that

Sequences must be in phylip format like this:
13 1245
African ATTTTTTTTTTT
Coyote  ATTTTTTTT
.....

Within the script SWAMP.sh change this /u/home/d/dechavez/project-rwayne/SWAMP/Sequences_LRT_4HD_d4_Smatools_phred33/All_genes/SWAMP_sequneces_10in15 
with this:
<path_of_current_directory>/SWAMP_sequneces_10in15 
and change this:
/u/home/d/dechavez/project-rwayne/SWAMP/Sequences_LRT_4HD_d4_Smatools_phred33/All_genes/SWAMP_sequneces_10in15_and_3in5 
with this:
<path_of_current_directory>/SWAMP_sequneces_10in15_and_3in5	

Now to run the pipiline do the following:
1. Provide your on newick file on the directory scripts/tree
1. Copy all phylip alingments to this directoy
2. Type: bash Make_directories.sh # this will create independnt files with the necesary subfolders to run downstream stpes 
3. To save memory remove the alignments that are NOT in subfolder, type the following:
for dir in Dir*; do (cd $dir && rm *.fasta);done #change '*.fasta' to whatever is the extention of your alignments 
4. Create subdirectories to paralalize the sequence, type the following:
i=0; for f in *; do d=dir_$(printf %03d $((i/100+1))); mkdir -p $d; mv "$f" $d; let i++; done
#in this term $((i/100+1))) you can change the 100 to the quantity you want in each directory.
5. Copy the files and script to each subdirectory, Type the following: 
for dir in Dir*; do (cp *.ctl $dir && cp SWAMP.sh $dir)
6. Replace the name of the directory within the SWAMP.sh script by typing the following:
for dir in Dir*; do (cd $dir && sed -i 's/dir001/'$dir'/g' SWAMP.sh);done
7. Run the script separtly for each subdirectory by typing the following:
for dir in Dir*; do (cd $dir && echo $dir && qsub SWAMP.sh);done


1. Run sibmt 1
2. Get table...give instructions and example file
3. Run submit 2


