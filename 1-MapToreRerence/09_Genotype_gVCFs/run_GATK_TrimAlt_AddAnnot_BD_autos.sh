#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highp,h_vmem=34G,h_rt=24:00:00,h_data=7G,arch=intel*
#$ -N trim_annot
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -m abe
#$ -M dechavezv
#$ -t 37-37:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/BD/VCF

java -jar -Xmx7g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V bsve04_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o bsve04_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V bsve04_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz \
-o bsve04_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt_Annot.vcf.gz 
