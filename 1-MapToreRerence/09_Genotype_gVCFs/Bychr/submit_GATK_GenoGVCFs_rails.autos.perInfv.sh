#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/gvcf
#$ -l highp,h_data=10G,h_rt=22:00:00,h_vmem=40G,arch=intel*
#$ -t 1-35:1
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa \
-allSites \
-L PseudoChr_$(printf "$SGE_TASK_ID") \
-V /u/scratch/d/dechavez/rails.project/gvcf/$1_LS_chr$(printf "$SGE_TASK_ID").g.vcf.gz \
-o /u/scratch/d/dechavez/rails.project/VCF/Indv/LS$1_chr$(printf "$SGE_TASK_ID").vcf.gz
