#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav
#$ -l highp,h_rt=10:00:00,h_data=1G
#$ -N subAlign
#$ -o /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/log/BWA
#$ -e /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/log/BWA
#$ -m abe
#$ -M dechavezv

export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam
export Direc=/u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav

cd ${Direc}

#for i in *MarkIlluminaAdapters.bam; do
##	FILENAME=${i%_MarkIlluminaAdapters.bam}
##	$QSUB $SCRIPTDIR/run_AlignCleanBam_QB3.sh ${FILENAME}
##	#sleep 3h
##done

$QSUB $SCRIPTDIR/run_AlignCleanBam_QB3.sh bsve313
