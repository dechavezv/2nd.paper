#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/vcfs
#$ -l h_rt=24:00:00,h_data=4G
#$ -N mendel
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins

BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.4.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.4.1/tabix

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPT=/u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/irnp_pipeline/11_FilterVCF/filterMendel_053117.py

# Filter sites failing Mendelian filter

cd /u/home/j/jarobins/project-rwayne/irnp/vcfs/variants

INFILE=IRNP_43_joint_chrX_TrimAlt_Annot_VEP_Masked_Filter_variants_lroh.vcf.gz

python ${SCRIPT} ${INFILE} | ${BGZIP} > ${INFILE%.vcf.gz}_Mendel.vcf.gz
${TABIX} -p vcf ${INFILE%.vcf.gz}_Mendel.vcf.gz
