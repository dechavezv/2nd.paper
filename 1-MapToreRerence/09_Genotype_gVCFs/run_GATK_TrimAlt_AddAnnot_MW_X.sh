#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -l h_rt=24:00:00,h_data=4G,highp,h_vmem=20G
#$ -q *@n7159
#$ -N n7159trim_annot
#$ -o /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -e /u/home/d/dechavez/project-rwayne/MW/VCF
#$ -m abe
#$ -M dechavezv

##h_vmem=INFINITI
#highmem

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/MW/VCF

java -jar -Xmx3g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V bcbr_joint_chrX.vcf.gz \
-o bcbr_joint_chrX_TrimAlt.vcf.gz

java -jar -Xmx3g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V bcbr_joint_chrX_TrimAlt.vcf.gz \
-o bcbr_joint_chrX_TrimAlt_Annot.vcf.gz
