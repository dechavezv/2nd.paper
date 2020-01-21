#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp
#$ -l h_rt=24:00:00,h_data=16G,arch=intel*
#$ -N cat_gVCFs
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 37-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp

FILE=$(ls $(printf %02d $SGE_TASK_ID)*.bam)
PREF=${FILE%_chrX.bam}

java -cp /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
org.broadinstitute.gatk.tools.CatVariants \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-assumeSorted \
$(for j in ${PREF}*chrX_*.g.vcf.gz; do echo "-V ${j} "; done) \
-out ${PREF}_chrX.g.vcf.gz
