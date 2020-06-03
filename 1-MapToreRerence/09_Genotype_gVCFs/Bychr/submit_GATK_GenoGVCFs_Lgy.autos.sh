#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet/Lgy/GVCFs
#$ -l highp,h_data=10G,h_rt=33:00:00,h_vmem=30G
#$ -t 22-22:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/Lgy/GVCFs/log/
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/Lgy/GVCFs/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(echo "-V /u/home/d/dechavez/project-rwayne/Lvet/Lgy/GVCFs/Lgy01_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz") \
-o /u/home/d/dechavez/project-rwayne/Lvet/Lgy/VCF/Lgy01_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
