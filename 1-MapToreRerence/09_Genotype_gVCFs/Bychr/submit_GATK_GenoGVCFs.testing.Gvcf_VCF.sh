#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Testing
#$ -l highp,h_data=10G,h_rt=24:00:00,h_vmem=30G,arch=intel*
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/Testing/log/
#$ -e /u/scratch/d/dechavez/Testing/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr38 \
-V /u/scratch/d/dechavez/Testing/Lgy01_chr38.g.vcf.gz \
-V /u/scratch/d/dechavez/Testing/Lve01_chr38.vcf.gz \
-o /u/scratch/d/dechavez/Testing/testing.Lgy.Lve.vcf.gz
