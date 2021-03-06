#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -l highmem,highp,h_rt=24:00:00,h_data=10G,h_vmem=40G,arch=intel*
#$ -N trim_annot
#$ -o /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -e /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -m abe
#$ -M dechavezv
### #$ -t 2-2:1

#highmem

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/MW/VCF
chr=$1

java -jar -Xmx10g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V bcbr05_chr${chr}.vcf.gz \
-o bcbr05_chr${chr}_TrimAlt.vcf.gz

java -jar -Xmx10g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V bcbr05_chr${chr}_TrimAlt.vcf.gz \
-o bcbr05_chr${chr}_TrimAlt_Annot.vcf.gz 
