#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highmem,highp,h_data=10G,h_rt=28:00:00,h_vmem=30G,arch=intel*
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chrX \
$(for j in {04..4}; do echo "-V /u/scratch/d/dechavez/BD/GVCFs/bsve${j}_chrX.g.vcf.gz "; done) \
-o /u/home/d/dechavez/project-rwayne/BD/VCF/bsve_joint_chrX.vcf.gz
