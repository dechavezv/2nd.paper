#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/vcfs
#$ -l h_rt=24:00:00,h_data=2G
#$ -N IRNPMendel
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1:38:1

# Usage: qsub run_checkMendel_IRNP_020817.sh

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/10_FilterVCF

cd /u/home/j/jarobins/project-rwayne/irnp/vcfs

python ${SCRIPTDIR}/checkMendel_IRNP_021017.py $(ls *chr$(printf %02d ${SGE_TASK_ID})*vcf.gz) ${SGE_TASK_ID}
