#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=06:00:00,h_data=8G
#$ -N foxfltr2
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-nightly-2016-11-15-ge744f1e/GenomeAnalysisTK.jar
CpGandRepeats=/u/home/j/jarobins/project-rwayne/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

java -jar ${GATK} \
-T VariantFiltration \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--logging_level ERROR \
--mask ${CpGandRepeats} --maskName "FAIL_CpGRep" \
-filter "VariantType == INDEL || VariantType == MIXED || VariantType == MNP || VariantType == SYMBOLIC || VariantType == MULTIALLELIC_SNP" \
--filterName "FAIL_type" \
-filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0 || ExcessHet > 10.0 || ABHet < 0.2 || ABHet > 0.8" \
--filterName "FAIL_8f" \
-filter "AN < 24" --filterName "FAIL_miss" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP > 396" --filterName "FAIL_DP" \
-G_filter "isCalled && DP<6" -G_filterName "loIdp" \
-G_filter "! isHomRef && GQ<20" -G_filterName "loIgq" \
--setFilteredGtToNocall \
-L chr$(printf %02d $SGE_TASK_ID) \
-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz \
-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_fltr.vcf.gz

#java -jar ${GATK} \
#-T SelectVariants \
#-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
#--excludeFiltered \
#--maxNOCALLfraction 0.2 \
#-trimAlternates \
#-L chr$(printf %02d $SGE_TASK_ID) \
#-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_fltr.vcf.gz \
#-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_fltr_select.vcf.gz
