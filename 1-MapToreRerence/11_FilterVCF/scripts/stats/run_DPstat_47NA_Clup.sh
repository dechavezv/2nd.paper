#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/VCF
#$ -l highp,h_rt=10:00:00,h_data=6G,highp,h_vmem=20G
#$ -N DP_VCF
#$ -o /u/home/d/dechavez/project-rwayne/Clup/VCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/Clup/VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-1:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

export Input=/u/home/d/dechavez/project-rwayne/Clup/VCF
export Out=/u/home/d/dechavez/project-rwayne/Clup/VCF/Stats

java -jar /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
--allowMissingData \
-GF DP \
-L chr$(printf %02d $SGE_TASK_ID) \
-V ${Input}/NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz \
-o ${Out}/NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz_DP.table
