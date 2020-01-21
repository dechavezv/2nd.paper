#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=21G,arch=intel*
#$ -N trimAlt
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp/joint_vcfs

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V IRNP_43_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o IRNP_43_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz
