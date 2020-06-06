#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/VCF
#$ -l highp,h_rt=22:00:00,h_data=5G,arch=intel*,h_vmem=30G 
#$ -N Hete.rail 
#$ -o /u/scratch/d/dechavez/rails.project/VCF/log/ 
#$ -e /u/scratch/d/dechavez/rails.project/VCF/log/
#$ -m abe 
#$ -M dechavezv 
#$ -t 1-35:1

#highmem_forced=TRUE

# EXAMPLE USAGE:
# SCRIPT=/wynton/home/walllab/robinsonj/project/scripts/SlidingWindowHet/SlidingWindowHet_20190910_submit_condor_20190910.sh
# cd /wynton/scratch/robinsonj/condor/Filter
# cp /wynton/home/walllab/robinsonj/project/condor/reference/chrom_lengths.txt .
# NUMJOBS=30
# qsub -t 1-${NUMJOBS} ${SCRIPT}

source /u/local/Modules/default/init/modules.sh
module load python/2.7

direc=/u/scratch/d/dechavez/rails.project/VCF
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/SlidingWindowHet.Rails.py

cd ${direc}

IDX=PseudoChr_$(printf ${SGE_TASK_ID})
VCF=$(ls *_chr$(printf ${SGE_TASK_ID}_*Mask_Filter.vcf.gz ))

python2.7 ${SCRIPT} ${VCF} 100000 100000 ${IDX}
