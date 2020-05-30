#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/SNPRelate
#$ -l highmem,highp,h_rt=70:00:00,h_data=20G,highp,h_vmem=40G
#$ -N snprelateRails
#$ -o /u/scratch/d/dechavez/rails.project/SNPRelate/log/NAClup.out
#$ -e /u/scratch/d/dechavez/rails.project/SNPRelate/log/NAClup.err
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load R/3.6.0

cd /u/scratch/d/dechavez/rails.project/SNPRelate

R CMD BATCH /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/PCA/snprelate_PCA_cluster_rail.R
