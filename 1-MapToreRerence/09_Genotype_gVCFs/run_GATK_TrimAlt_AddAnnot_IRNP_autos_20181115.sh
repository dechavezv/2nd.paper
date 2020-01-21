#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=32G,arch=intel*
#$ -N trim_annot
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 19-19:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/flashscratch/j/jarobins/vcfs

java -jar -Xmx26g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V IRNP_44_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o IRNP_44_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz


java -jar -Xmx26g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_44_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz \
-o IRNP_44_joint_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt_Annot.vcf.gz 
