#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highmem,highp,h_data=20G,h_rt=33:00:00,h_vmem=30G,arch=intel*
#$ -t 37-37:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {04..4}; do echo "-V /u/scratch/d/dechavez/BD/GVCFs/bsve${j}_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/home/d/dechavez/project-rwayne/BD/VCF/bsve04_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
