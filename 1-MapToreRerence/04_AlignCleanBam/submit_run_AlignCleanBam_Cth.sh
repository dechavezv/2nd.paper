#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l highp,h_rt=10:00:00,h_data=1G
#$ -N subAlign
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/BWA
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/BWA
#$ -m abe
#$ -M dechavezv

export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam
export Direc=/u/home/d/dechavez/project-rwayne/Cth/reads

cd ${Direc}

for i in *MarkIlluminaAdapters.bam; do
	FILENAME=${i%_MarkIlluminaAdapters.bam}
	$QSUB $SCRIPTDIR/run_AlignCleanBam_Cth.sh ${FILENAME}
	#sleep 3h
done


