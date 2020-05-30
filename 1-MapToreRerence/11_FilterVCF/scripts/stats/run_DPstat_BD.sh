#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highp,h_rt=02:00:00,h_data=6G,highp,h_vmem=20G
#$ -N DP_VCF_BD
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF/Stats/log/
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF/Stats/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

export Input=/u/home/d/dechavez/project-rwayne/BD/VCF
export Out=/u/home/d/dechavez/project-rwayne/BD/VCF/Stats

java -jar /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
--allowMissingData \
-GF DP \
-L chr$(printf %02d $SGE_TASK_ID) \
-V ${Input}/bsve_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz \
-o ${Out}/bsve_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP.table
