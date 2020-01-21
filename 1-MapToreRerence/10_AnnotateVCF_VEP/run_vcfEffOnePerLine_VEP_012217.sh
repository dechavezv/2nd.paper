#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/filtered
#$ -l h_rt=24:00:00,h_data=1G
#$ -N VEP1perline
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load perl

SCRIPTDIR=/u/project/mcdb/rwayne/jarobins/utils/scripts/bam_processing/11_AnnotateVCF_VEP
BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/filtered

zcat fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered_VEP.vcf.gz | \
perl ${SCRIPTDIR}/vcfEffOnePerLine_VEP.pl | \
$BGZIP > fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered_VEP_1perline.vcf.gz

$TABIX -p vcf fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered_VEP_1perline.vcf.gz
