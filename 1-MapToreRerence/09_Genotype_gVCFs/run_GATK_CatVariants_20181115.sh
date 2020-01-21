#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/gVCFs/chrX
#$ -l h_rt=04:00:00,h_data=20G,arch=intel*
#$ -N catVars
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/flashscratch/j/jarobins/gVCFs/chrX

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

java -cp ${GATK} org.broadinstitute.gatk.tools.CatVariants \
-R ${REFERENCE} \
-assumeSorted \
$(for j in $(ls IRNP_44_joint_chrX_{001..124}.vcf.gz); do echo "-V ${j} "; done) \
-out IRNP_44_joint_chrX.vcf.gz
