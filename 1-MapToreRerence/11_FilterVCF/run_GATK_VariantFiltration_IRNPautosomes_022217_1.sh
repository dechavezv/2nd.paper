#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint/annotated
#$ -l h_rt=24:00:00,h_data=12G
#$ -N IRNPfltr
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/j/jarobins/irnp/vcfs/joint/annotated

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
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_Annot.vcf.gz \
-o IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_Annot_Masked.vcf.gz
