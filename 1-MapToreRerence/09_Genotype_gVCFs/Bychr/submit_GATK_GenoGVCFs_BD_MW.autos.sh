#! /bin/bash

#$ -wd /u/scratch/d/dechavez/GVCF
#$ -l highp,h_data=20G,h_rt=33:00:00,h_vmem=30G,arch=intel*
#$ -t 1-38:1
#$ -N GTgVCF.MW_BD
#$ -o /u/scratch/d/dechavez/GVCF/log/
#$ -e /u/scratch/d/dechavez/GVCF/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {01..4}; do echo "-V /u/scratch/d/dechavez/GVCF/bsve${j}_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz "; done) \
$(for j in {04..5}; do echo "-V /u/scratch/d/dechavez/GVCF/bcbr${j}_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/HKA/bsve_bcbr_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
