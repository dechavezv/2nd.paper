#! /bin/bash

#$ -wd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N SAtotHet
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

# Usage: qsub run_HetPerInd_SA.sh

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/TotalHete

Direc=/u/scratch/d/dechavez/SA.VCF/Filtered/20200530

cd ${Direc}


#for line in $(cat /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH/list.sp.ROH.Het.txt); do /
#python ${SCRIPTDIR}/HetPerInd_SA.py $(ls ${line}_chr$(printf %02d $SGE_TASK_ID)*vcf.gz) ${SGE_TASK_ID};done

python ${SCRIPTDIR}/HetPerInd_SA.py $(ls Lculp01_chr$(printf %02d $SGE_TASK_ID)*vcf.gz) ${SGE_TASK_ID}
