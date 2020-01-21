#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Jackal
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/scratch/d/dechavez/Jackal/log/MarkDup/
#$ -e /u/scratch/d/dechavez/Jackal/log/MarkDup/
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/Jackal

cd $DIRECT

#sleep 2h
                                                            
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_jackal.sh Caur_Aligned.jackal.bam Caur_Aligned.MarkDup.jackal.bam 2500
