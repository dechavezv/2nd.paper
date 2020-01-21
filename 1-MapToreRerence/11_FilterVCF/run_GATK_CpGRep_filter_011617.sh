#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=12:00:00,h_data=8G
#$ -N maskCpGRep
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/AddAnnotations

TABIX=/u/project/mcdb/rwayne/jarobins/utils/programs/htslib-1.3.1/tabix

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
CpGandRepeats=/u/home/j/jarobins/project-rwayne/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

$TABIX -p vcf fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz

java -jar -Xmx4g ${GATK} \
-T VariantFiltration \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--logging_level ERROR \
--mask ${CpGandRepeats} --maskName "CpGRep" \
-L chr$(printf %02d $SGE_TASK_ID) \
-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz \
-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep.vcf.gz
