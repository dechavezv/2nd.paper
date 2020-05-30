#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/GVCF
#$ -l highp,h_data=37G,h_rt=48:00:00,h_vmem=60G,arch=intel*
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Clup/GVCF/log/reports.X
#$ -e /u/home/d/dechavez/project-rwayne/Clup/GVCF/log/reports.X
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

#must do from 45-47

java -jar -Xmx37g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chrX \
$(for j in {01..47}; do echo "-V /u/home/d/dechavez/project-rwayne/Clup/GVCF/${j}_NA_Clup_chrX.g.vcf.gz"; done) \
-o /u/home/d/dechavez/project-rwayne/Clup/VCF/NA_CLup_joint_chrX.vcf.gz


