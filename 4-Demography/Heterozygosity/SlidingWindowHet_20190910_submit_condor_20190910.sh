#! /bin/bash
#$ -cwd
#$ -l h_rt=24:00:00,mem_free=4G
#$ -N winHet
#$ -o /wynton/home/walllab/robinsonj/project/reports/condor/SlidingWindowHet
#$ -e /wynton/home/walllab/robinsonj/project/reports/condor/SlidingWindowHet
#$ -V


# EXAMPLE USAGE:
# SCRIPT=/wynton/home/walllab/robinsonj/project/scripts/SlidingWindowHet/SlidingWindowHet_20190910_submit_condor_20190910.sh
# cd /wynton/scratch/robinsonj/condor/Filter
# cp /wynton/home/walllab/robinsonj/project/condor/reference/chrom_lengths.txt .
# NUMJOBS=30
# qsub -t 1-${NUMJOBS} ${SCRIPT}


SCRIPT=/wynton/home/walllab/robinsonj/project/scripts/SlidingWindowHet/SlidingWindowHet_20190910.py

IDX=$(printf %03d ${SGE_TASK_ID})
CHROM=$(cut -f1 chrom_lengths.txt | head -n ${SGE_TASK_ID} | tail -n 1 )
VCF=$(ls *_${IDX}_*.vcf.gz )

python2.7 ${SCRIPT} ${VCF} 1000000 1000000 ${CHROM}



