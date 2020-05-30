#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highp,h_rt=24:00:00,h_data=9G,highp,h_vmem=34G
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -m abe
#$ -M dechavezv

##h_vmem=INFINITI
#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/BD/VCF

java -jar -Xmx6g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V bsve_joint_chrX.vcf.gz \
-o bsve_joint_chrX_TrimAlt.vcf.gz

java -jar -Xmx6g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V bsve_joint_chrX_TrimAlt.vcf.gz \
-o bsve_joint_chrX_TrimAlt_Annot.vcf.gz
