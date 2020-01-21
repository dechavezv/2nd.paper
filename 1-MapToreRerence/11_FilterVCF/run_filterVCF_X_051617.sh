#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N IRNPfltr
#$ -o /u/home/j/jarobins/project-rwayne/reports/fox
#$ -e /u/home/j/jarobins/project-rwayne/reports/fox
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load python

MYDIR=/u/home/j/jarobins/project-rwayne
SCRIPTDIR=${MYDIR}/utils/scripts/bam_processing/irnp_pipeline/11_FilterVCF

TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix
BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip

VCFDIR=/u/scratch2/j/jarobins/irnp/joint_vcfs

cd ${VCFDIR}

VCF_FILE=IRNP_43_joint_chrX_TrimAlt_Annot_VEP_Masked_rename_reorder.vcf.gz

set -o pipefail

python ${SCRIPTDIR}/filterVCF_051917.py ${VCFDIR}/${VCF_FILE} | \
${BGZIP} > ${VCFDIR}/${VCF_FILE%_rename_reorder.vcf.gz}_Filter.vcf.gz

${TABIX} -p vcf ${VCFDIR}/${VCF_FILE%_rename_reorder.vcf.gz}_Filter.vcf.gz
