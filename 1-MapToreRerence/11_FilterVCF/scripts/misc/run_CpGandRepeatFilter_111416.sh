#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=04:00:00,h_data=2G
#$ -N rm_CpG_Rep
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

MYDIR=/u/home/j/jarobins/project-rwayne/

TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix

INTERSECTBED=${MYDIR}/utils/programs/bedtools2/bin/intersectBed

BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip

CPGandREPEATS=${MYDIR}/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

VCFDIR=${MYDIR}/fox/vcfs/joint_vcfs/trim_alternates/


cd ${VCFDIR}


${TABIX} -h ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_raw.vcf.gz chr$(printf %02d $SGE_TASK_ID) |
${INTERSECTBED} -v -sorted -header -a stdin -b ${CPGandREPEATS} | 
${BGZIP} > ${VCFDIR}/fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_rmCpGandRepeats.vcf.gz
