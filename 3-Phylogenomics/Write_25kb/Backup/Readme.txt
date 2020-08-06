This folder contain all the script and bed files used to calculate phylogenies in RAXML and Astral
The following are a short the scription of eahc file:

#Individual Genotype calling gVCF
#Joint gvcf of all Canids genomes
GATK_HaplotypeCaller_GVCFs.sh 


# Get Number of informative sites among canids genomes within 25kb windows.
python SlidingWindowAllCanids_v2.py 2nd_call_cat_samt_ug_hc_AllCanids_ALLchr.g.vcf.gz > Windows_25kb_filtered_Phylogeny_Statv2.txt

# Get genes from BAM files
Get_fasta_from_BAM.sh

# Merge exons of the same transcript and Format aligments
Get_genes_from_Fasta.sh

1)Get_phylogeny.sh

3)Windows_25kb_filtered_Phylogeny_Statv2.txt --> File with information necessary to wirte a bed file of 25kb windos.
This is also useful to get sumary statistic such as mean, SD, quariles of the windows.
You can also plot things like lenght of site with inforamtion vs Quality tod etect posible bias in the anlysis 

4)Write_BedFile.py --> Write the bed file using the file in step (2) as input. Important!!! tou must calculate the window_end in 
previous file before runing this step. You can calculate the aformentioned value just by adding 25,000 to the colum named window_start  

2)25kb_Windows_goodQual.bed --> is the bed file of 25kb with good quality

3)Canis_familiaris_all.bed --> is the bed file with coordinates of Orthologs genes of the domestic dog Acording to Freedman et al., 2014 

4)Get_Partition_25kbWindows.py --> is an script desing to get a bed file with the position of coding region relative a particular ~25kb window
For instance: if the longest transcript of gene A strats in position 10,000 within the 25kb window and ends in position 10,400, then the bed fie will be:
chr01\t10,000\t10,400 
NOTE that the previous calculated position is diferent ot the actuall position of the transcript within the chromosome  

5)Longest_Transcript.bed --> Has the bed filec corresponding to the longest transcript from all posible trascript shown in step (3)  

6)partition_1st_2nd_3rd.py --> Gets the fasta sequence of 1st,2nd and 3rd codon-based of each Ortholog gene 

7) partition_finder.cfg --> Is the configuration file necessary for Partition Finder


#Individual Genotype calling gVCF
#Joint gvcf of all Canids genomes
GATK_HaplotypeCaller_GVCFs.sh


# Get Number of informative sites among canids genomes within 25kb windows.
python SlidingWindowAllCanids_v2.py 2nd_call_cat_samt_ug_hc_AllCanids_ALLchr.g.vcf.gz > Windows_25kb_filtered_Phylogeny_Statv2.txt

echo '###############'
echo Coding_Bed_Files
echo '###############'
#for this script to work you must sum window_start + 25,000 within the document Windows_25kb_filtered_Phylogeny_Statv2.txt to get window_end
python Write_BedFile.py Windows_25kb_filtered_Phylogeny_Statv2.txt 25kb_Windows_goodQual.bed

echo '###############'
echo Coding_Bed_Files_within_windows
echo '###############'
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
echo Get_25kb_fasta_alignments
echo '###############'

export BAM=/u/scratch/d/dechavez/African/2nd_call_cat_samt_ug_hc_fb_Wildog_raw_Reheader.vcf.table.bam
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Output=/u/scratch/d/dechavez/African
export BED=/u/home/d/dechavez/project-rwayne/Besd_Files/Canis_familiaris_all.bed

cd ${Output}

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} |
bcftools call -c |
vcfutils.pl vcf2fq -d 4 -D <95th percentile Total coverage> -Q 20 > ${BAM}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM}.fq > ${BAM}_d4_D<95th>_phred33.fa
bedtools getfasta -fi ${BAM}.fa -bed ${BED} -fo ${BAM}_25kb.fa


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


##############################
export BAM=/u/scratch/d/dechavez/African/2nd_call_cat_samt_ug_hc_fb_Wildog_raw_Reheader.vcf.table.bam
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Output=/u/scratch/d/dechavez/African
export BED=/u/home/d/dechavez/project-rwayne/Besd_Files/Canis_familiaris_all.bed

cd ${Output}

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} |
bcftools call -c |
vcfutils.pl vcf2fq -d 4 -D <95th percentile Total coverage> -Q 20 > ${BAM}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM}.fq > ${BAM}_d4_D<95th>_phred33.fa
bedtools getfasta -fi ${BAM}.fa -bed ${BED} -fo ${BAM}_25kb.fa
