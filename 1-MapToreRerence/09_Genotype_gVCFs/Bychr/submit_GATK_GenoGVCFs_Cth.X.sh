#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/GVCF
#$ -l highp,h_data=8G,h_rt=18:00:00,h_vmem=20G,arch=intel*
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Cth/GVCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Cth/GVCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx8g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chrX \
$(echo "-V /u/home/d/dechavez/project-rwayne/Cth/GVCF/bCth_chrX.g.vcf.gz") \
-o /u/home/d/dechavez/project-rwayne/Cth/VCF/bCth_chrX.vcf.gz
