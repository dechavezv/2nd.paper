#$ -l highp,h_rt=21:00:00,h_data=4G
#$ -pe shared 1
#$ -N Get_phylogeny
#$ -cwd
#$ -m bea
#$ -o ./Get_phylogeny.out
#$ -e ./Get_phylogeny.err
#$ -M dechavezv
#$ -t 1-<number_of_Folders_in_RAXML_step>:1

echo '###############'
echo Coding_Bed_Files
echo '###############'
#for this script to work you must sum window_start + 25,000 within the document Windows_25kb_filtered_Phylogeny_Statv2.txt to get window_end
python Write_BedFile.py Windows_25kb_filtered_Phylogeny_Statv2.txt 25kb_Windows_goodQual.bed

echo '###############'
echo Coding_Bed_Files_within_windowsecho '###############'
python Get_Partition_25kbWindows.py 25kb_Windows_goodQual.bed Longest_Transcript.bed

echo '###############'
echo Delete_empty_files
echo '###############'
#Some windows did not have genes within them
for file in chr*; do if [ -s $file ]; then echo Not empty;else rm $file;fi;done

echo '###############'
echo Non_coding_Bed_Files
echo '###############'
#Get the bed none coding region within each window
#bedtools complement will get the corrdinates not specify in the bed file of Ortho genes information
#If you want to get oly fasta sequences you can skipe this and go to 
for file in chr*; do ( echo $file && ~/bedtools2/bin/bedtools complement -i $file -g 25kb_$(printf $file | sed 's/_.*//g').bed > Neutral_$file.bed);done

echo '###############'
echo Edit_names_of_aligments
echo '###############'
perl -pe 's/(>chr\d+) /\1_/g' prank_chr01\:56675801-56700801.fas > Edited_prank_chr01\:56675801-56700801.fa

echo '###############'
echo  Extract_CDS_and_NoCoding     
echo '###############'
/u/home/d/dechavez/phast/phast/bin/msa_split prank_chr01:56675801-56700801.fas --features chr01_56675801_56700801.bed --by-category --out-root mydata
#the oupult will be two files: 
#1.The non_coding sequnece named <name_of_file>.background-0.fa
#2.The coding seuence named <name_of_file>feature-1.fa


echo '##############'
echo  Get_codon_partions_for_JmodelTest
echo '###############'
#Get 1st,2nd and 3rd base of each codoing region or Ortholog gene
python partition_1st_2nd_3rd.py mydata.bed_feature-1.fa


echo '###############'
echo  Calculate_model_test
echo '###############'
java -jar /u/home/d/dechavez/jmodeltest-2.1.10/jModelTest.jar -d mydata.bed_feature-1.faPartirion_1.txt -f -i -g 4 -s GTR -AIC -a

#Note if you are no going to run Jmodel test skipe this step and go to the netx one (Partition finder)

echo '###############'
echo  Prepare_Files_for_PartitionFinder
echo '###############'
#In this case only Orthologs genes were processsed 
#make a directry for each gene
for file in EN*; do (mkdir -p dir_$file && echo $file && cp $file dir_$file && /
#cp configuration file to each folder
cp partition_finder.cfg dir_$file && cd dir_$file &&/
#within the configuration file "partition_finder.cfg" edite 759 with the corresponding lenght of each gene
d=$(printf $(grep '13' $file | sed 's/13 //g')) && sed -i 's/759/'$d'/;s/align.phy/'$file'/g' partition_finder.cfg);done

echo '###############'
echo  Calculate_Partition_Finder
echo '###############'
for dir in EN*; do (echo $dir && /
/u/home/d/dechavez/anaconda2/bin/python2.7 ~/partitionfinder-2.1.1/PartitionFinder.py $dir --raxml);done

echo '###############'
echo  Calculate_Raxml
echo '###############'
#if you wnat to parrelalize the job you can do the following 
i=0; for f in EN*; do d=dir_$(printf %03d $((i/100+1))); mkdir -p $d; mv "$f" $d; let i++; done
#folder	will be	dir_001, dir_002, etc (depent on how many files you expecify each folder to have)
#then go within each folder and run RAXML  
cd dir_$(printf "%03d" "$SGE_TASK_ID")

for dir in ENS*; do \
if [ $(grep 'Best Model' -n1 $dir/analysis/best_scheme.txt | grep 'GTR' | perl -pe 's/.*(GT[R,I,G,+]+)\s+|.*/\1/g') == 'GTR' ]
then
/u/home/d/dechavez/standard-RAxML-8.2.11/raxmlHPC-SSE3 -f a -x 12345 -p 12345 -# 100 -m GTRCAT -s $dir/EN* -n $(printf $file)_raxml);done
elif [ $(grep 'Best Model' -n1 $dir/analysis/best_scheme.txt | grep 'GTR' | perl -pe 's/.*(GT[R,I,G,+]+)\s+|.*/\1/g') == GTR+I ]
then
/u/home/d/dechavez/standard-RAxML-8.2.11/raxmlHPC-SSE3 -f a -x 12345 -p 12345 -# 100 -m GTRCATI -s $dir/EN* -n $(printf $file)_raxml);done
elif [ $(grep 'Best Model' -n1 $dir/analysis/best_scheme.txt | grep 'GTR' | perl -pe 's/.*(GT[R,I,G,+]+)\s+|.*/\1/g') == GTR+G ]
then
/u/home/d/dechavez/standard-RAxML-8.2.11/raxmlHPC-SSE3 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMA -s $dir/EN* -n $(printf $file)_raxml);done
else [ $(grep 'Best Model' -n1 $dir/analysis/best_scheme.txt | grep 'GTR' | perl -pe 's/.*(GT[R,I,G,+]+)\s+|.*/\1/g') == GTR+I+G ]
then
/u/home/d/dechavez/standard-RAxML-8.2.11/raxmlHPC-SSE3 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMAI -s $dir/EN* -n $(printf $file)_raxml);done
fi;done

echo '###############'
echo  Calculate_Astral
echo '###############'
#create the folder where all best trees will be sorted at
mkdir best_files

#move all boostrap files to a folder created in the previous step 
mv RAxML_bootstrap* best_files

#cat all bestrees, name it Canis_Raxml_all_bestTrees_raxml, and move it to folder with boostrap trees
cat *bestTree* > Canis_Raxml_all_bestTrees_raxml

#run Raxml
java -jar /u/home/d/dechavez/ASTRAL/astral.5.5.3.jar -i Canis_Raxml_all_bestTrees_raxml -b best_files
