#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -l h_rt=20:00:00,h_data=21G,highp
#$ -t 23-26:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/MW/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/MW/VCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-stand_emit_conf 0 \
-stand_call_conf 0 \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {01..4}; do echo "-V /u/scratch/d/dechavez/MW/GVCFs/bcbr${j}_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/home/d/dechavez/project-rwayne/MW/VCF/MW_allSamples_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
