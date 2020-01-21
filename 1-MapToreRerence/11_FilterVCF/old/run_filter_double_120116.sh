#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=10:00:00,h_data=8G
#$ -N foxfltr2.2
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/AddAnnotations

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-nightly-2016-11-15-ge744f1e/GenomeAnalysisTK.jar
CpGandRepeats=/u/home/j/jarobins/project-rwayne/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

java -jar ${GATK} \
-T VariantFiltration \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--logging_level ERROR \
--mask ${CpGandRepeats} --maskName "FAIL_CpGRep" \
-filter "VariantType != SNP || VariantType != NO_VARIATION" --filterName "FAIL_type" \
-filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0 || ExcessHet > 4.0" \
--filterName "FAIL_7f" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP > 396" --filterName "FAIL_DP" \
-G_filter "isCalled && DP<6" -G_filterName "loIdp" \
-G_filter "! isHomRef && GQ<30" -G_filterName "loIgq" \
--setFilteredGtToNocall \
-L chr$(printf %02d $SGE_TASK_ID) \
-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz \
-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_fltrtemp.vcf.gz

java -jar ${GATK} \
-T VariantFiltration \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--logging_level ERROR \
-filter "AN < 24" --filterName "FAIL_miss" \
-L chr$(printf %02d $SGE_TASK_ID) \
-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_fltrtemp.vcf.gz \
-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_fltr.vcf.gz
