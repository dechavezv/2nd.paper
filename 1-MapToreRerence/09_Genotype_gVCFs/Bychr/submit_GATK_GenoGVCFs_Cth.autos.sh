#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/GVCF
#$ -l highp,h_data=8G,h_rt=33:00:00,h_vmem=30G
#$ -t 21-21:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Cth/GVCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Cth/GVCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx8g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(echo "-V /u/home/d/dechavez/project-rwayne/Cth/GVCF/bCth_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz") \
-o /u/home/d/dechavez/project-rwayne/Cth/VCF/bCth_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
