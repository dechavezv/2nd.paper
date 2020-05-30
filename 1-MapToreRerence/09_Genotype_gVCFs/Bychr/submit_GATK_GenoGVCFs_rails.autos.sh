#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/gvcf
#$ -l highmem,highp,h_data=40G,h_rt=22:00:00,h_vmem=50G,arch=intel*
#$ -t 3-3:1
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/rails.project/gvcf/log/
#$ -e /u/scratch/d/dechavez/rails.project/gvcf/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa \
-allSites \
-L PseudoChr_$(printf "$SGE_TASK_ID") \
$(for j in {01..8}; do echo "-V /u/scratch/d/dechavez/rails.project/gvcf/${j}_LS_chr$(printf "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/rails.project/VCF/LS_joint_chr$(printf "$SGE_TASK_ID").vcf.gz
