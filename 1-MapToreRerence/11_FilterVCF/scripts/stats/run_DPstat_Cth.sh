#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/VCF
#$ -l h_rt=08:00:00,h_data=4G,highp,h_vmem=20G
#$ -N DP_VCF
#$ -o /u/home/d/dechavez/project-rwayne/Cth/VCF/Stats/log/
#$ -e /u/home/d/dechavez/project-rwayne/Cth/VCF/Stats/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

export Input=/u/home/d/dechavez/project-rwayne/Cth/VCF
export Out=/u/home/d/dechavez/project-rwayne/Cth/VCF/Stats

java -jar /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
--allowMissingData \
-GF DP \
-L chr$(printf %02d $SGE_TASK_ID) \
-V ${Input}/bCth_chr$(printf %02d $SGE_TASK_ID).vcf.gz \
-o ${Out}/bCth_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP.table
