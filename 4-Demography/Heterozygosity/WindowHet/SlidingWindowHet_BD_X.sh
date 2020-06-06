#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highp,h_rt=14:00:00,h_data=6G,arch=intel*,h_vmem=30G
#$ -N Hete
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -m abe
#$ -M dechavezv

# EXAMPLE USAGE:
# SCRIPT=/wynton/home/walllab/robinsonj/project/scripts/SlidingWindowHet/SlidingWindowHet_20190910_submit_condor_20190910.sh
# cd /wynton/scratch/robinsonj/condor/Filter
# cp /wynton/home/walllab/robinsonj/project/condor/reference/chrom_lengths.txt .
# NUMJOBS=30
# qsub -t 1-${NUMJOBS} ${SCRIPT}

source /u/local/Modules/default/init/modules.sh
module load python/2.7

direc=/u/home/d/dechavez/project-rwayne/BD/VCF
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/SlidingWindowHet.py

cd ${direc}

IDX=chrX
VCF=$(ls *_${IDX}_*Mask_Filter.vcf.gz )

python2.7 ${SCRIPT} ${VCF} 100000 100000 ${IDX}
