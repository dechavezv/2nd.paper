#! /bin/bash
#$ -wd /u/scratch/d/dechavez/HKA
#$ -l highp,h_vmem=44G,h_rt=34:00:00,h_data=7G,arch=intel*
#$ -N trim_annot.BD_MW.X
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -m abe
#$ -M dechavezv

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/scratch/d/dechavez/HKA

java -jar -Xmx7g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V bsve_bcbr_chrX.vcf.gz \
-o bsve_bcbr_chrX_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V bsve_bcbr_chrX_TrimAlt.vcf.gz \
-o bsve_bcbr_chrX_TrimAlt_Annot.vcf.gz 
