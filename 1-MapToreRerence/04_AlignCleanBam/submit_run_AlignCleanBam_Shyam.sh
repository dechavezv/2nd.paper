#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/TG
#$ -l highp,h_rt=14:00:00,h_data=1G
#$ -N subAlign
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/BWA
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/BWA
#$ -m abe
#$ -M dechavezv

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam

cd /u/home/d/dechavez/project-rwayne/Clup/reads/TG

for i in *MarkIlluminaAdapters.bam; do
	FILENAME=${i%_MarkIlluminaAdapters.bam}
	$QSUB $SCRIPTDIR/run_AlignCleanBam_Shyam.sh ${FILENAME}
done
