#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/snprelate
#$ -l h_rt=24:00:00,h_data=8G,highp
#$ -N snprelate
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/home/j/jarobins/project-rwayne/irnp/snprelate

R CMD BATCH /u/home/j/jarobins/project-rwayne/utils/scripts/snprelate/snprelate_PCA_cluster_053117.R
