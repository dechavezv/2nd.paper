#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF
#$ -l highp,h_rt=24:00:00,h_data=20G,h_vmem=44G
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv

##h_vmem=INFINITI
#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/BD/VCF

java -jar -Xmx20g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V bsve04_chrX.vcf.gz \
-o bsve04_chrX_TrimAlt.vcf.gz

java -jar -Xmx20g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V bsve04_chrX_TrimAlt.vcf.gz \
-o bsve04_chrX_TrimAlt_Annot.vcf.gz
