#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/GVCF
#$ -l highmem,highp,h_data=34G,h_rt=49:00:00,h_vmem=50G,arch=intel*
#$ -t 1-1:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Clup/GVCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/GVCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx34g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {01..4}; do echo "-V /u/scratch/d/dechavez/QB3ateloc/${j}_AmiDgr_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/QB3ateloc/${j}_AmiDgr_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz
