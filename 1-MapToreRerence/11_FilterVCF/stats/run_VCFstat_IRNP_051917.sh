#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=12G,arch=intel*
#$ -N VCFstat
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp/joint_vcfs

java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--allowMissingData \
--splitMultiAllelic \
-F DP -F ExcessHet -F HET -F NCALLED \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP_Masked_Filter.vcf.gz \
-o IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP_Masked_Filter.vcf.gz_StatsTable.txt
