#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=16G,arch=intel*
#$ -N reorder
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

VCF=${1}

cd /u/flashscratch/j/jarobins/vcfs

java -jar -Xmx8g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-V ${VCF} \
-o ${VCF%.vcf.gz}_reorder.vcf.gz 
