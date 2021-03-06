#! /bin/bash

#$ -l h_rt=24:00:00,h_data=5G,highp,h_vmem=10G,arch=intel*
#$ -N msmc_rail
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/log/
#$ -M dechavezv
#$ -t 1-1:1

# make an array for all your chromsome/scaffolds

source /u/local/Modules/default/init/modules.sh
module load python
module load perl

msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master/msmc

# date you called genotypes:
date=20200520
wd=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/${date} # your working directory


i=$(printf $SGE_TASK_ID) # chunk
# # THE vcf file is already masked for sites outside of coverage range and for genotypes that have a dot (./.), as well as having indels and all sites not passing filters removed

vcf=${wd}/LS$1_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz # this has already gone through masking

# PREP FOR MSMC:
mkdir -p ${wd}/msmcAnalysis
mkdir -p ${wd}/msmcAnalysis/inputFiles

/u/home/d/dechavez/anaconda3/bin/python3 ${msmc_tools}/generate_multihetsep.py ${vcf} > ${wd}/msmcAnalysis/inputFiles/chunk_LS$1_${i}_postMultiHetSep.txt
