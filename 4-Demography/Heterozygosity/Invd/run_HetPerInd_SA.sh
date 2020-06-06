#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/vcfs
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N IRNPTotHet
#$ -o /u/home/j/jarobins/project-rwayne/irnp/reports
#$ -e /u/home/j/jarobins/project-rwayne/irnp/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-39:1

# Usage: qsub run_HetPerInd_IRNP_013117_array.sh directory_with_files

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/j/jarobins/project-rwayne/utils/scripts/totalhet

cd ${1}

python ${SCRIPTDIR}/HetPerInd_IRNP_013117.py $(ls *chr$(printf %02d $SGE_TASK_ID)*vcf.gz) ${SGE_TASK_ID}
