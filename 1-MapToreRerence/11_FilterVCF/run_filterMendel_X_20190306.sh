#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/new/vcfs/variants
#$ -l h_rt=02:00:00,h_data=4G
#$ -N mendel
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp/Annotation
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp/Annotation
#$ -m abe
#$ -M jarobins


BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.4.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.4.1/tabix

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPT=/u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/irnp_pipeline/11_FilterVCF/filterMendel_20190306.py

cd /u/home/j/jarobins/project-rwayne/irnp/new/vcfs/variants

INFILE=IRNP_44_joint_chrX_TrimAlt_Annot_VEP_Masked_Filter_vars.vcf.gz

python ${SCRIPT} ${INFILE} | ${BGZIP} > ${INFILE%.vcf.gz}_Mendel.vcf.gz
${TABIX} -p vcf ${INFILE%.vcf.gz}_Mendel.vcf.gz
