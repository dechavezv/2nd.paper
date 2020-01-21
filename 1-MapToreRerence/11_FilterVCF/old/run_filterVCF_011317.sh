#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=06:00:00,h_data=2G,arch=intel*
#$ -N fox_filter
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/AddAnnotations

MYDIR=/u/home/j/jarobins/project-rwayne

SCRIPTDIR=$MYDIR/utils/scripts/filtervcf

VCFDIR=/u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates

TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix

INTERSECTBED=${MYDIR}/utils/programs/bedtools2/bin/intersectBed

BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip

CPGandREPEATS=${MYDIR}/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

set -o pipefail

python ${SCRIPTDIR}/filterVCF_011317.py ${VCFDIR}/AddAnnotations/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz | \
${INTERSECTBED} -v -sorted -header -a stdin -b ${CPGandREPEATS} | \
${BGZIP} > ${VCFDIR}/filtered2/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_filtered2.vcf.gz; \
${TABIX} -p vcf ${VCFDIR}/filtered2/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_filtered2.vcf.gz
