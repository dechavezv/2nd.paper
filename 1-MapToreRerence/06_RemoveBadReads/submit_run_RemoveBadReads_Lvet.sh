#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l highp,h_rt=10:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/scratch/d/dechavez/IndelReal/log/bamfilter.out
#$ -e /u/scratch/d/dechavez/IndelReal/log/bamfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/IndelReal

${QSUB} -N bamfiltr $SCRIPT_DIR/run_RemoveBadReads_Lvet.sh BBJ_BWA_sortRG_rmdup_realign_fixmate.bam

#for file in *MarkDup_Filtered.bam; do
## ${QSUB} -N bamfiltr $SCRIPT_DIR/run_RemoveBadReads_Lvet.sh ${file}
#done
