#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/gVCFs
#$ -l h_rt=04:00:00,h_data=32G,arch=intel*
#$ -N GTgVCF_IRNP_X
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 75-75:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/irnp_pipeline/09_Genotype_gVCFs/coords
coords=$(cat $(ls chrX_coords.list_* | head -n ${SGE_TASK_ID} | tail -n 1))

cd /u/flashscratch/j/jarobins/gVCFs/chrX

java -jar -Xmx26g ${GATK} \
-T GenotypeGVCFs \
-R ${REFERENCE} \
-allSites \
-stand_call_conf 0 \
-L ${coords} \
$(for j in *_IRNP_*_chrX.g.vcf.gz; do echo "-V ${j} "; done) \
-o IRNP_44_joint_chrX_$(printf "%03d" "$SGE_TASK_ID").vcf.gz 
