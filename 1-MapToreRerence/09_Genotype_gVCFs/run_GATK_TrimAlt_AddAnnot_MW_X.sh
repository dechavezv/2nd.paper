#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF 
#$ -l h_rt=24:00:00,h_data=12G,highp,h_vmem=20G
#$ -N trim_annot
#$ -o /u/scratch/d/dechavez/SA.VCF/log
#$ -e /u/scratch/d/dechavez/SA.VCF/log
#$ -m abe
#$ -M dechavezv

##h_vmem=INFINITI
#highmem

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
PREFIX=$1

cd /u/home/d/dechavez/project-rwayne/MW/VCF

java -jar -Xmx12g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V ${PREFIX}_chrX.vcf.gz \
-o ${PREFIX}_chrX_TrimAlt.vcf.gz

java -jar -Xmx12g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V ${PREFIX}_chrX_TrimAlt.vcf.gz \
-o ${PREFIX}_chrX_TrimAlt_Annot.vcf.gz
