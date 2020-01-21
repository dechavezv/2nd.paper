#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=16G
#$ -N MaskFilter
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 19-19:1

source /u/local/Modules/default/init/modules.sh
module load java
module load python

cd /u/flashscratch/j/jarobins/vcfs

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
CpGandRepeats=/u/home/j/jarobins/project-rwayne/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

java -jar ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
--logging_level ERROR \
--mask ${CpGandRepeats} --maskName "FAIL_CpGRep" \
-filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0" \
--filterName "FAIL_6f" \
-filter "QUAL < 30.0" --filterName "FAIL_qual" \
-filter "DP > 1373" --filterName "FAIL_DP" \
-L chr$(printf %02d $SGE_TASK_ID) \
-V IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP.vcf.gz \
-o IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP_Masked.vcf.gz


echo "VariantFiltration complete."
date
echo "Beginning custom filtering."

TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix
BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip

SCRIPT=/u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/irnp_pipeline/11_FilterVCF/filterVCF_20181117.py
VCF=IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP_Masked.vcf.gz

set -o pipefail

python ${SCRIPT} ${VCF} | ${BGZIP} > ${VCF%.vcf.gz}_Filter.vcf.gz

${TABIX} -p vcf ${VCF%.vcf.gz}_Filter.vcf.gz

echo "Custom filtering complete."
date
