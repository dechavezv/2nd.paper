#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=12G
#$ -N Mask_IRNP
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp/joint_vcfs

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
CpGandRepeats=/u/home/j/jarobins/project-rwayne/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

java -jar ${GATK} \
-T VariantFiltration \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--logging_level ERROR \
--mask ${CpGandRepeats} --maskName "FAIL_CpGRep" \
-filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0" \
--filterName "FAIL_6f" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP > 1473" --filterName "FAIL_DP" \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP.vcf.gz \
-o IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP_Masked.vcf.gz
