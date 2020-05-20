#!/bin/bash

#$ -l highmem,highp,h_rt=15:00:00,h_data=1G
#$ -N msmc_BD
#$ -pe shared 11
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/BD/BQR/Inv.HC_VCF/log/MW.msmc.out
#$ -e /u/scratch/d/dechavez/BD/BQR/Inv.HC_VCF/log/MW.msmc.err
#$ -M dechavezv
### #$ -t 1-38:1
###### $(printf %02d $SGE_TASK_ID)

VCF=/u/scratch/d/dechavez/BD/BQR/Inv.HC_VCF
msmc_files=/u/scratch/d/dechavez/BD/BQR/Inv.HC_VCF/msmc_files
OUTDIR=/u/scratch/d/dechavez/BD/BQR/Inv.HC_VCF/MSCM_OUT
msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master
tbx=/u/home/d/dechavez/tabix-0.2.6
export script=/u/home/d/dechavez/project-rwayne/scripts

## $tbx/bgzip -c *filtered* > Reheader_filtered_$f.vcf.gz && \
## $tbx/tabix -p vcf Reheader_filtered_$f.vcf.gz && \


#Parallelized
cd $VCF

# then load your modules:
source /u/local/Modules/default/init/modules.sh
module load bcftools
module load bzip2
module load python

## echo '##############################'
## echo 'Change header chr$1'
## echo '##############################'
## bcftools reheader -s ${script}/header.txt ${VCF}/2nd_call_cat_samt_ug_hc_MW_chr$1.vcf.gz > ${VCF}/Reheader_2nd_call_cat_samt_ug_hc_MW_chr$1.vcf.gz
## ${tabix}/tabix -p vcf ${VCF}/Reheader_2nd_call_cat_samt_ug_hc_MW_chr$1.vcf.gz

# echo '##############################'
# echo 'Filtering gVCG of chr$1'
# echo '##############################'
# python -W ignore ${script}/Python/Filter_Indv_Canids_Wild_dogs.py \
# ${VCF}/2nd_call_cat_samt_ug_hc_MW_chr$1.vcf.gz $1

# echo '##############################'
# echo 'Get only vatiants that passed filters'
# echo '##############################'

# gunzip 2nd_call_cat_samt_ug_hc_bushDog_chr$1_5miss_filtered_v5.vcf.gz
# grep -v 'FAIL' 2nd_call_cat_samt_ug_hc_MW_chr$1_filtered.vcf > bushDog_BWA_sortRG_rmdup_realign_fixmate_chr$1_OnlyPassfiltered.vcf
# $tbx/bgzip -c 2nd_call_cat_samt_ug_hc_MW_chr$1_filtered.vcf > 2nd_call_cat_samt_ug_hc_bushDog_chr$1_filtered.vcf.gz
# $tbx/tabix -p vcf 2nd_call_cat_samt_ug_hc_bushDog_chr$1_filtered.vcf.gz
# $tbx/bgzip -c bushDog_BWA_sortRG_rmdup_realign_fixmate_chr$1_OnlyPassfiltered.vcf > bushDog_BWA_sortRG_rmdup_realign_fixmate_chr$1_OnlyPassfiltered.vcf.gz
# $tbx/tabix -p vcf bushDog_BWA_sortRG_rmdup_realign_fixmate_chr$1_OnlyPassfiltered.vcf.gz
# rm 2nd_call_cat_samt_ug_hc_bushDog_chr$1_filtered.vcf
# rm bushDog_BWA_sortRG_rmdup_realign_fixmate_chr$1_OnlyPassfiltered.vcf

# echo '##############################'
# echo 'Prepate file for MSMC'
# echo '##############################'

# /u/home/d/dechavez/anaconda3/bin/python3 $msmc_tools/generate_multihetsep.py MW_BWA_sortRG_rmdup_realign_fixmate_chr$1_OnlyPassfiltered.vcf.gz > $msmc_files/MW_filtered_postMultiHetSep_chr$1.txt

echo '##############################'
echo 'Run MSMC'
echo '##############################'
# Run the folling just once for all chromosomes
echo 'Starting MSMC' &&  \
$msmc/msmc -t 11 -o $OUTDIR/msmc_bushDog_allchr.out $msmc_files/bushDog_filtered_postMultiHetSep_chr*.txt
