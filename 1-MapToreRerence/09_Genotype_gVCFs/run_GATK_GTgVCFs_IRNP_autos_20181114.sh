#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/gVCFs
#$ -l h_rt=24:00:00,h_data=32G,arch=intel*
#$ -N GTgVCF_IRNP
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 19-19:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/flashscratch/j/jarobins/gVCFs/chr$(printf "%02d" "$SGE_TASK_ID")

java -jar -Xmx26g ${GATK} \
-T GenotypeGVCFs \
-R ${REFERENCE} \
-allSites \
-stand_call_conf 0 \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in *_IRNP_*_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz; do echo "-V ${j} "; done) \
-o IRNP_44_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz 

