#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Ethiopian
#$ -l h_data=10G,h_rt=24:00:00,h_vmem=20G,arch=intel*
#$ -t 01-38:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Ethiopian/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Ethiopian/VCF/log/reports
#$ -m abe
#$ -M dechavezv

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-V /u/scratch/d/dechavez/Ethiopian/GVCFs/Csmi01_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz \
-o /u/scratch/d/dechavez/Ethiopian/VCF/Csmi01_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
