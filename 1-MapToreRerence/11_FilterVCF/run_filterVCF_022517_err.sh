#! /bin/bash
#$ -wd /u/scratch/j/jarobins/
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N IRNPfltr2
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins
#$ -t 35-35:1

source /u/local/Modules/default/init/modules.sh
module load python

MYDIR=/u/home/j/jarobins/project-rwayne

SCRIPTDIR=${MYDIR}/utils/scripts/bam_processing/11_FilterVCF

TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix

# INTERSECTBED=${MYDIR}/utils/programs/bedtools2/bin/intersectBed

BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip

# CPGandREPEATS=${MYDIR}/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

VCFDIR=/u/scratch/j/jarobins/irnp/vcfs/joint/annotated

cd ${VCFDIR}

VCF_FILE=$(ls IRNP_35*$(printf %02d $SGE_TASK_ID)*Masked.vcf.gz)

set -o pipefail

# python ${SCRIPTDIR}/filterVCF_010717.py ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz | \
# ${INTERSECTBED} -v -sorted -header -a stdin -b ${CPGandREPEATS} | \
# ${BGZIP} > ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_filtered.vcf.gz; \
# ${TABIX} -p vcf ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_filtered.vcf.gz

python ${SCRIPTDIR}/filterVCF_022517.py ${VCFDIR}/${VCF_FILE} | \
${BGZIP} > ${VCFDIR}/${VCF_FILE%.vcf.gz}2.vcf.gz

${TABIX} -p vcf ${VCFDIR}/${VCF_FILE%.vcf.gz}2.vcf.gz
