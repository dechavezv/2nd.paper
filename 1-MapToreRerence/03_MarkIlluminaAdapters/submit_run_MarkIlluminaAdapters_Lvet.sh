#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l highp,h_rt=12:00:00,h_data=1G
#$ -N subMrkIlAd
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/log/MkrIlAdp
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/log/MkrIlAdp
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/03_MarkIlluminaAdapters

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/Lvet

for i in ./*.bam; do
	$QSUB $SCRIPTDIR/run_MarkIlluminaAdapters_Lvet.sh ${i}
#	sleep 30m
done
