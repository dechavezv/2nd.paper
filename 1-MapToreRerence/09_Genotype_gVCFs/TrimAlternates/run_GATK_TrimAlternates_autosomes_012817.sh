#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint
#$ -l h_rt=24:00:00,h_data=21G,arch=intel*
#$ -t 1-38:1
#$ -N trimAlt
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/scratch/j/jarobins/irnp/vcfs/joint

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V $DIR/IRNP_35_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o $DIR/IRNP_35_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz
