#! /bin/bash

#$ -wd /u/scratch/d/dechavez/BD
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/scratch/d/dechavez/BD/log/MarkDup
#$ -e /u/scratch/d/dechavez/BD/log/MarkDup
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/BD

#sleep 2h
                                                            
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_BD.sh BD.bam_Aligned.bam BD.bam_Aligned.MarkDup.bam
