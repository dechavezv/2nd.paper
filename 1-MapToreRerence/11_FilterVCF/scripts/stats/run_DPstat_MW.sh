#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -l h_rt=02:00:00,h_data=12G,highp
#$ -N DP_VCF
#$ -o /u/home/d/dechavez/project-rwayne/MW/VCF/Stats/log/
#$ -e /u/home/d/dechavez/project-rwayne/MW/VCF/Stats/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

export Input=/u/home/d/dechavez/project-rwayne/MW/VCF
export Out=/u/home/d/dechavez/project-rwayne/MW/VCF/Stats

java -jar /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
--allowMissingData \
-GF DP \
-L chr$(printf %02d $SGE_TASK_ID) \
-V ${Input}/bcbr_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz \
-o ${Out}/bcbr_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP.table
