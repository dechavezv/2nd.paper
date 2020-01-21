#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N fox_filter
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python

MYDIR=/u/home/j/jarobins/project-rwayne

SCRIPTDIR=${MYDIR}/utils/scripts/bam_processing/10_FilterVCF

VCFDIR=${MYDIR}/fox/vcfs/joint_vcfs/trim_alternates

TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix

# INTERSECTBED=${MYDIR}/utils/programs/bedtools2/bin/intersectBed

BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip

# CPGandREPEATS=${MYDIR}/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

cd ${VCFDIR}/AddAnnotations

set -o pipefail

# python ${SCRIPTDIR}/filterVCF_010717.py ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz | \
# ${INTERSECTBED} -v -sorted -header -a stdin -b ${CPGandREPEATS} | \
# ${BGZIP} > ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_filtered.vcf.gz; \
# ${TABIX} -p vcf ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_filtered.vcf.gz

python ${SCRIPTDIR}/filterVCF_011717.py ${VCFDIR}/AddAnnotations/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep.vcf.gz | \
${BGZIP} > ${VCFDIR}/filtered/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered.vcf.gz

${TABIX} -p vcf ${VCFDIR}/filtered/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered.vcf.gz
