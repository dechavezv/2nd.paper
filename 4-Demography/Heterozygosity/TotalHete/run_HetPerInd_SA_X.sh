#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N totHet
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

# Usage: qsub run_HetPerInd_050117_array.sh directory_with_files

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/j/jarobins/project-rwayne/utils/scripts/totalhet

cd ${1}

python ${SCRIPTDIR}/HetPerInd_050117.py $(ls IRNP*chrX*vcf.gz)
