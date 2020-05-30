#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Ethiopian/VCF
#$ -l highmem_forced=TRUE,highp,h_data=9G,h_rt=33:00:00,h_vmem=30G,arch=intel*
#$ -t 01-38:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Ethiopian/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Ethiopian/VCF/log/reports
#$ -m abe
#$ -M dechavezv

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx7g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-V /u/scratch/d/dechavez/Ethiopian/GVCF/Ethiopian_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz \
-o /u/home/d/dechavez/project-rwayne/Eth/VCF/Eth_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
