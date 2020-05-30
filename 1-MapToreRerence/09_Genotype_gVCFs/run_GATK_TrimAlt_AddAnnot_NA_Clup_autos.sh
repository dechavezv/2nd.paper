#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/VCF
#$ -l highmem,highp,h_vmem=44G,h_rt=44:00:00,h_data=24G,arch=intel*
#$ -N trimAnnotClup
#$ -o /u/home/d/dechavez/project-rwayne/Clup/VCF/log/TrimAnotClup.23
#$ -e /u/home/d/dechavez/project-rwayne/Clup/VCF/log/TrimAnotClup.23
#$ -m abe
#$ -M dechavezv
#$ -t 1-1:1


#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/home/d/dechavez/project-rwayne/Clup/VCF

java -jar -Xmx24g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V NA_CLup_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o NA_CLup_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V NA_CLup_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz \
-o NA_CLup_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt_Annot.vcf.gz 
