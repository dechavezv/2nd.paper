#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/VCF
#$ -l highmem,highp,h_vmem=44G,h_rt=24:00:00,h_data=24G,arch=intel*
#$ -N trimAnnotClup
#$ -o /u/home/d/dechavez/project-rwayne/Clup/VCF/log/TrimAnotClup
#$ -e /u/home/d/dechavez/project-rwayne/Clup/VCF/log/TrimAnotClup
#$ -m abe
#$ -M dechavezv

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/Clup/VCF

java -jar -Xmx24g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V NA_CLup_joint_chrX.vcf.gz \
-o NA_CLup_joint_chrX_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V NA_CLup_joint_chrX_TrimAlt.vcf.gz \
-o NA_CLup_joint_chrX_TrimAlt_Annot.vcf.gz 
