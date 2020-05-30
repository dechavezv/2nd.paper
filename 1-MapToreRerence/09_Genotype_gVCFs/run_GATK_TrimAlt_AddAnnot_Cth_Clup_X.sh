#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Cth/VCF
#$ -l highp,h_vmem=44G,h_rt=44:00:00,h_data=24G,arch=intel*
#$ -N trimAnnotCth
#$ -o /u/home/d/dechavez/project-rwayne/Cth/VCF/log/trimAnot.X
#$ -e /u/home/d/dechavez/project-rwayne/Cth/VCF/log/trimAnot.X
#$ -m abe
#$ -M dechavezv


#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/Cth/VCF

java -jar -Xmx24g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V bCth_chrX.vcf.gz \
-o bCth_chrX_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V bCth_chrX_TrimAlt.vcf.gz \
-o bCth_chrX_TrimAlt_Annot.vcf.gz
