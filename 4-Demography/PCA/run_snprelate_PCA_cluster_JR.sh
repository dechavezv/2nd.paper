#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/SNPRelate
#$ -l h_rt=24:00:00,h_data=14G,highp
#$ -N snprelateClup
#$ -o /u/home/d/dechavez/project-rwayne/Clup/SNPRelate/log/NAClup.out
#$ -e /u/home/d/dechavez/project-rwayne/Clup/SNPRelate/log/NAClup.err
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load R/3.6.0

cd /u/home/d/dechavez/project-rwayne/Clup/SNPRelate

R CMD BATCH /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/PCA/snprelate_PCA_cluster_JR.R 
