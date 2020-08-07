#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l h_rt=4:00:00,h_data=1G
#$ -N subSplitBam
#$ -o /u/scratch/d/dechavez/IndelReal/log/subSplitBam
#$ -e /u/scratch/d/dechavez/IndelReal/log/subSplitBam
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/scripts
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/IndelReal

#sleep 2h

cd ${DIRECT}

for file in *bam; do ${QSUB} -N Splitbam $SCRIPTDIR/run_split_bams.rail.sh $file; done
