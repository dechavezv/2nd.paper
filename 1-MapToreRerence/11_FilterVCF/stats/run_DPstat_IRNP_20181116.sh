#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=12G,arch=intel*
#$ -N IRNP_DPstat
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/flashscratch/j/jarobins/vcfs

java -jar ${GATK} \
-T VariantsToTable \
-R ${REFERENCE} \
--allowMissingData \
--splitMultiAllelic \
-F DP \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz \
-o IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz_DPStatsTable.txt
