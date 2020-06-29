#! /bin/bash

#$ -wd /u/scratch/d/dechavez/GVCF
#$ -l highp,h_data=20G,h_rt=33:00:00,h_vmem=30G,arch=intel*
#$ -N GTgVCF.MW_BD.X
#$ -o /u/scratch/d/dechavez/GVCF/log/
#$ -e /u/scratch/d/dechavez/GVCF/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chrX \
$(for j in {01..4}; do echo "-V /u/scratch/d/dechavez/GVCF/bsve${j}_chrX.g.vcf.gz "; done) \
$(for j in {01..5}; do echo "-V /u/scratch/d/dechavez/GVCF/bcbr${j}_chrX.g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/HKA/bsve_bcbr_chrX.vcf.gz
