#! /bin/bash

#$ -wd /u/scratch/d/dechavez/red.fox/raw.reads
#$ -l highp,h_rt=14:00:00,h_data=1G
#$ -N subAlign
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/BWA
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/BWA
#$ -m abe
#$ -M dechavezv

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam

cd /u/home/d/dechavez/project-rwayne/Clup/reads/BV

$QSUB $SCRIPTDIR/run_AlignCleanBam_BV.sh ClupSRR7976408_eastern_wolf.single.bam_MarkIlluminaAdapters.bam

#for i in *MarkIlluminaAdapters.bam; do
#	FILENAME=${i%_MarkIlluminaAdapters.bam}
#	$QSUB $SCRIPTDIR/run_AlignCleanBam_BV.sh ${FILENAME}
#done
