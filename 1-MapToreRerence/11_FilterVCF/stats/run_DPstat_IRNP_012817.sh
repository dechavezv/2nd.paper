#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint
#$ -l h_rt=24:00:00,h_data=8G,arch=intel*
#$ -N IRNP_DPstat
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/j/jarobins/irnp/vcfs/joint

java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--allowMissingData \
--splitMultiAllelic \
-F DP -F AN -F ExcessHet -F HET -F NCALLED \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz \
-o IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz_StatsTable.txt
