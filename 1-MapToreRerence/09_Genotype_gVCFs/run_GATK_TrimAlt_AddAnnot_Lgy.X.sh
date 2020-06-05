#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Lvet/Lgy/VCF
#$ -l highp,h_vmem=34G,h_rt=24:00:00,h_data=10G,arch=intel*
#$ -N LgyTrimAnnot
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/Lgy/VCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/Lgy/VCF/log/
#$ -m abe
#$ -M dechavezv

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/Lvet/Lgy/VCF

java -jar -Xmx10g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V Lgy01_chrX.vcf.gz \
-o Lgy01_chrX_TrimAlt.vcf.gz

java -jar -Xmx10g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V Lgy01_chrX_TrimAlt.vcf.gz \
-o Lgy01_chrX_TrimAlt_Annot.vcf.gz 
