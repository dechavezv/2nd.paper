#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530
#$ -l h_rt=24:00:00,h_data=2G,arch=intel*
#$ -N SAtotHet.X
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv

# Usage: qsub HetPerInd_SA.sh

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/TotalHete

Direc=/u/scratch/d/dechavez/SA.VCF/Filtered/20200530
cd ${Direc}

python ${SCRIPTDIR}/HetPerInd_SA.py $(ls *chrX*vcf.gz)
