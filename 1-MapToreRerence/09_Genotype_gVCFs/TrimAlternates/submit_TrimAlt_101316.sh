#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs
#$ -l h_rt=24:00:00,h_data=21G,highp
#$ -t 1-37:1
#$ -N trimAlt
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/updatedGATK

java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-nightly-2016-10-06-g026f7e8/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V $DIR/fox01_15_joint_GATK_HC_BPR_chr$(printf "%02d" "$SGE_TASK_ID")_2.vcf.gz \
-o $DIR/fox01_15_joint_GATK_HC_BPR_chr$(printf "%02d" "$SGE_TASK_ID")_2_TrimAlt.vcf.gz
