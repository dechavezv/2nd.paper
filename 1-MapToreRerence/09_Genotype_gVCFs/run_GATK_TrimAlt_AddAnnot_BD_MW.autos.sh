#! /bin/bash
#$ -wd /u/scratch/d/dechavez/HKA
#$ -l highp,h_vmem=44G,h_rt=34:00:00,h_data=7G,arch=intel*
#$ -N trim_annot.BD_MW
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-1:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/scratch/d/dechavez/HKA

java -jar -Xmx7g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V bsve_bcbr_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o bsve_bcbr_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V bsve_bcbr_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz \
-o bsve_bcbr_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt_Annot.vcf.gz 
