#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/
#$ -l h_rt=02:00:00,h_data=8G,highp
#$ -N DPstat
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 3-38:1

source /u/local/Modules/default/init/modules.sh
module load java

java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-nightly-2016-10-06-g026f7e8/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--allowMissingData \
-F DP \
-L chr$(printf %02d $SGE_TASK_ID) \
-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_raw.vcf.gz \
-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_raw.vcf.gz_DP.table
