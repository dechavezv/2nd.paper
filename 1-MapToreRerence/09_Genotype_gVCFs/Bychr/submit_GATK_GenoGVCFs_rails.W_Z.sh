#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/gvcf
#$ -l highp,h_data=6G,h_rt=99:00:00,h_vmem=30G,arch=intel*
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/rails.project/VCF/indv/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/indv/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-8:1

source /u/local/Modules/default/init/modules.sh
module load java

i=$(printf "%02d" "$SGE_TASK_ID")

java -jar -Xmx6g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa \
-allSites \
-L PseudoChr_W \
-V /u/scratch/d/dechavez/rails.project/gvcf/${i}_LS_chrW.g.vcf.gz \
-o /u/scratch/d/dechavez/rails.project/VCF/Indv/LS${i}_chrW.vcf.gz
