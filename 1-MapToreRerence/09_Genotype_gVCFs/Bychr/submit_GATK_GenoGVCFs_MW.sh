#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -l h_data=20G,h_rt=72000,h_vmem=67G,arch=intel*,highp
#$ -t 27-27:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/MW/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/MW/VCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {05..5}; do echo "-V /u/scratch/d/dechavez/MW/GVCFs/bcbr${j}_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/home/d/dechavez/project-rwayne/MW/VCF/bcbr${j}_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
