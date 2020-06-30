#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Coyotes
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/scratch/d/dechavez/Coyotes/log/
#$ -e /u/scratch/d/dechavez/Coyotes/log/
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/Coyotes

#sleep 2h

for file in *_Aligned.bam; do
	${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_Coyotes.sh $file ${file%.bam}.MarkDup.bam
done                                                            
