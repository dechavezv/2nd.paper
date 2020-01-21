#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=4G,arch=intel*
#$ -N IRNPfltr
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins


source /u/local/Modules/default/init/modules.sh
module load python

MYDIR=/u/home/j/jarobins/project-rwayne
SCRIPTDIR=${MYDIR}/utils/scripts/bam_processing/irnp_pipeline/11_FilterVCF

TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix
BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip

VCFDIR=/u/flashscratch/j/jarobins/vcfs

cd ${VCFDIR}

VCF_FILE=IRNP_44_joint_chrX_TrimAlt_Annot_VEP_Masked.vcf.gz

set -o pipefail

python ${SCRIPTDIR}/filterVCF_20181117.py ${VCFDIR}/${VCF_FILE} | \
${BGZIP} > ${VCFDIR}/${VCF_FILE%.vcf.gz}_Filter.vcf.gz

${TABIX} -p vcf ${VCFDIR}/${VCF_FILE%.vcf.gz}_Filter.vcf.gz
