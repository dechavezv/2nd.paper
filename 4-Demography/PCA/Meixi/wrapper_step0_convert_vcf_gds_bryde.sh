#! /bin/bash
#$ -wd /u/project/rwayne/meixilin/fin_whale/analyses
#$ -l highp,highmem,h_rt=48:00:00,h_data=30g,h_vmem=45g
#$ -o /u/project/rwayne/meixilin/fin_whale/analyses/reports/SNPRelate.out.txt
#$ -e /u/project/rwayne/meixilin/fin_whale/analyses/reports/SNPRelate.err.txt
#$ -m abe

# Usage: qsub wrapper_step0_convert_vcf_gds_bryde.sh 
source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
conda activate gentools

WORKDIR=/u/project/rwayne/meixilin/fin_whale/analyses/SNPRelate/
WORKSCRIPT=/u/project/rwayne/meixilin/fin_whale/analyses/SNPRelate/scripts/step0_convert_vcf_gds.R
LOG=/u/project/rwayne/meixilin/fin_whale/analyses/reports/step0_convert_vcf_gds_bryde.log

cd ${WORKDIR}
date "+%Y-%m-%d %T" > ${LOG}

Rscript --vanilla ${WORKSCRIPT} "Bryde" 23 &>> ${LOG}

date "+%Y-%m-%d %T" >> ${LOG}
conda deactivate 