#! /bin/bash
#$ -cwd
#$ -l h_rt=30:00:00,h_data=10G,highp,h_vmem=50G
#$ -N msmcPrep
#$ -o /u/scratch/d/dechavez/rails.project/VCF/msmc/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/msmc/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-36
# make an array for all your chromsome/scaffold files -t 1- (# of chromosomes)
source /u/local/Modules/default/init/modules.sh
module load python/3.4
module load perl


msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master/msmc

# date you called genotypes:
date=20200520
wd=/u/scratch/d/dechavez/rails.project/VCF/msmc/${date} # your working directory 

i=${SGE_TASK_ID} # chunk
#PREFIX=01_Elut_CA_Gidget
# # THE vcf file is already masked for sites outside of coverage range and for genotypes that have a dot (./.), as well as having indels and all sites not passing filters removed 

vcf=$wd/LS_joint_chr${1}_TrimAlt_Annot_Mask_Filter_Allalleles_passingSNPs.vcf # this has already gone through masking

# PREP FOR MSMC: 
echo "starting msmc prep"
mkdir -p $wd/msmcAnalysis
mkdir -p $wd/msmcAnalysis/inputFiles
$msmc_tools/generate_multihetsep.py $vcf > $wd/msmcAnalysis/inputFiles/chunk_${i}_postMultiHetSep.txt

