#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l highp,h_rt=12:00:00,h_data=1G
#$ -N subMrkIlAd
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/MkrIlAdp
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/MkrIlAdp
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/03_MarkIlluminaAdapters

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/Cth/reads

for i in ./*.bam; do
	$QSUB $SCRIPTDIR/run_MarkIlluminaAdapters_Cth.sh ${i}
#	sleep 30m
done
