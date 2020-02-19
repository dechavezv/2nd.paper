#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l highp,h_rt=24:00:00,h_data=3G
#$ -N subAlign
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/log/BWA
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/log/BWA
#$ -m abe
#$ -M dechavezv

export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam
export Direc=/u/home/d/dechavez/project-rwayne/Lvet

cd ${Direc}

$QSUB $SCRIPTDIR/run_AlignCleanBam_Lvet.sh bPgy20

##for i in *MarkIlluminaAdapters.bam; do
##	FILENAME=${i%_MarkIlluminaAdapters.bam}
##	$QSUB $SCRIPTDIR/run_AlignCleanBam_Lvet.sh ${FILENAME}
##	#sleep 3h
#done
