#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint
#$ -l h_rt=24:00:00,h_data=12G,arch=intel*
#$ -N IRNPfltr
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/j/jarobins/irnp/vcfs/joint

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
CpGandRepeats=/u/home/j/jarobins/project-rwayne/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

java -jar ${GATK} \
-T VariantFiltration \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--logging_level ERROR \
--mask ${CpGandRepeats} --maskName "FAIL_CpGRep" \
-filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0" \
--filterName "FAIL_6f" \
-filter "ExcessHet > 4.0" --filterName "FAIL_exHet" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP > 2779" --filterName "FAIL_DP" \
-G_filter "isCalled && DP<6" -G_filterName "loIdp" \
-G_filter "! isHomRef && GQ<30" -G_filterName "loIgq" \
-G_filter "isHomRef && RGQ<30" -G_filterName "loIgq" \
--setFilteredGtToNocall \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt.vcf.gz \
-o IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_filtered.vcf.gz

