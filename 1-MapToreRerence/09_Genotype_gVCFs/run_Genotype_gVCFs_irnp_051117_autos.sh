#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/gvcfs
#$ -l h_rt=24:00:00,h_data=22G,arch=intel*
#$ -t 1-38:1
#$ -N GTgVCF_IRNP
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp/gvcfs/chr$(printf "%02d" "$SGE_TASK_ID")

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-allSites \
-stand_call_conf 0 \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {01..43}_IRNP_*_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz; do echo "-V ${j} "; done) \
-o IRNP_43_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz 

