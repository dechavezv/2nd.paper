#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/SNPRelate
#$ -l highp,highmem,h_rt=48:00:00,h_data=30g,h_vmem=45g
#$ -o /u/home/d/dechavez/project-rwayne/Clup/SNPRelate/log/SNPRelate.47NAClup.out.txt
#$ -e /u/home/d/dechavez/project-rwayne/Clup/SNPRelate/log/SNPRelate.47NAClup.err.txt
#$ -m abe

# Usage: qsub wrapper_step0_convert_vcf_gds_bryde.sh 
## source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
## conda activate gentools

WORKDIR=/u/home/d/dechavez/project-rwayne/Clup/SNPRelate
WORKSCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/PCA/step0_convert_vcf_gds.R
LOG=/u/home/d/dechavez/project-rwayne/Clup/SNPRelate/step0_convert_vcf_gds_47NAClup.log

cd ${WORKDIR}
date "+%Y-%m-%d %T" > ${LOG}

Rscript --vanilla ${WORKSCRIPT} "47_Clup" 38 &>> ${LOG}

date "+%Y-%m-%d %T" >> ${LOG}
