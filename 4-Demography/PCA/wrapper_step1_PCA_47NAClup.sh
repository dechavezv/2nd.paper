#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/SNPRelate
#$ -l highp,h_rt=48:00:00,h_data=40g,h_vmem=75g
#$ -o /u/home/d/dechavez/project-rwayne/Clup/SNPRelate/MeixiAnnabelPipe/log/SNPRelate.47NAClup.out.txt
#$ -e /u/home/d/dechavez/project-rwayne/Clup/SNPRelate/MeixiAnnabelPipe/log/SNPRelate.47NAClup.err.txt
#$ -N plotPCAsnprelate
#$ -m abe
#$ -M dechavezv

#highmem

# Usage: qsub wrapper_step0_convert_vcf_gds_bryde.sh 
## source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
## conda activate gentools

# load your modules:
. /u/local/Modules/default/init/modules.sh
module load R/3.6.0

WORKDIR=/u/home/d/dechavez/project-rwayne/Clup/SNPRelate/MeixiAnnabelPipe
WORKSCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/PCA/step1_PCA_gds.R
LOG=/u/home/d/dechavez/project-rwayne/Clup/SNPRelate/MeixiAnnabelPipe/step1_PCA_47NAClup.log
GDS=Filtered_47_Clup_all.gds


cd ${WORKDIR}
date "+%Y-%m-%d %T" > ${LOG}

Rscript --vanilla ${WORKSCRIPT} ${WORKDIR} ${GDS} "47_Clup" &>> ${LOG}

date "+%Y-%m-%d %T" >> ${LOG}
