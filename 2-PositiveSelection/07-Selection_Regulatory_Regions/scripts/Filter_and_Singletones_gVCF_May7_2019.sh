#!/bin/bash

#$ -l h_rt=10:00:00,h_data=1G
#$ -pe shared 1
#$ -N GVCFs.Sep24
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/d/dechavez/GVCFs/log/GVCFs_Sep24.out
#$ -e /u/flashscratch/d/dechavez/GVCFs/log/GVCFs_Sep24.err
#$ -M dechavezv

#highmem,highp

# highmem
# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load bzip2
module load python

export gVCF=/u/scratch/d/dechavez/GVCFs
export script=/u/home/d/dechavez/project-rwayne/scripts
export tabix=/u/home/d/dechavez/tabix-0.2.6
export bed=/u/home/d/dechavez/project-rwayne/Besd_Files


Singletones_fn () {

#	echo "********* Changing Header of $1 **************"

#	bcftools reheader -s ${script}/header.txt ${gVCF}/$1.vcf.gz > ${gVCF}/Reheader_$1.vcf.gz; \
#	${tabix}/tabix -p vcf ${gVCF}/Reheader_$1.vcf.gz

#	echo "********* Filtering gVCG of $1 **************"

#	python -W ignore ${script}/Python/Filter_VCF_ALL_Canids_Singletones_May7_2019.py \
#	${gVCF}/Reheader_$1.vcf.gz chr$2

#	echo "********* Get Only Passed sites of $1 **************"
#	grep -v 'FAIL' ${gVCF}/Reheader_$1_5miss_filtered_v5.vcf > ${gVCF}/Reheader_$1_5miss_filtered_v5.OnlyPass.vcf			

#	echo "********* Compressing $1 **************"
#	${tabix}/bgzip -c ${gVCF}/Reheader_$1_5miss_filtered_v5.OnlyPass.vcf > ${gVCF}/Reheader_$1_5miss_filtered_v5.OnlyPass.vcf.gz
#	${tabix}/tabix -p vcf ${gVCF}/Reheader_$1_5miss_filtered_v5.OnlyPass.vcf.gz					

	echo "********* Calculating Singletones and Segregation of $1 **************"
 
	grep chr$2 ${bed}/Promoter_All_chr_March10th_2019.txt | while read line; do python -W ignore \
	${script}/Python/Calculate_SingleAndSegrega_OtherCanids.v3.py ${gVCF}/Reheader_$1_5miss_filtered_v5.OnlyPass.vcf.gz $line;done \
	> ${gVCF}/SameFile_SingleBySegreg/Sep24.Allchanges/SameFile_SingleBySegreg.BBJ.v2.Filter_v5.Onlypass.5miss_BBJ_SSJ_Sep24_chr$2.txt
	
	#Note:  use Calculate_SingleAndSegrega_BD_and_MW.v2.py o calculate singleBysegre of either BD or MW 
	#	use Calculate_SingleAndSegrega_OtherCanids.v3.py To calculate singleBysegre of othre canids (e.g AWD)
	#	use Calculate_SingleAndSegrega_BD_and_MW.v3.printAllSites.py To get raw num of sites unique in MW and BD.
}

Singletones_fn July2nd_2019_chr$1_canids $1
#Singletones_fn May6th_2019_chr$1_AllCanids $1
