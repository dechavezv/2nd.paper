#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet/Lve/GVCFs
#$ -l highp,h_data=20G,h_rt=24:00:00,h_vmem=30G,arch=intel*
#$ -t 32-32:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/Lve/GVCFs/log/
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/Lve/GVCFs/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(echo "-V /u/home/d/dechavez/project-rwayne/Lvet/Lvet/GVCFs/Lve01_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz") \
-o /u/home/d/dechavez/project-rwayne/Lvet/Lvet/VCF/Lve01_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
