#! /bin/bash
#$ -wd /u/scratch/d/dechavez/red.fox/raw.reads
#$ -l highp,h_rt=12:00:00,h_data=1G
#$ -N subMrkIlAd
#$ -o /u/scratch/d/dechavez/red.fox/raw.reads/log/MkrIlAdp
#$ -e /u/scratch/d/dechavez/red.fox/raw.reads/log/MkrIlAdp
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/03_MarkIlluminaAdapters

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/red.fox/raw.reads

for i in ./*.bam; do
	$QSUB $SCRIPTDIR/run_MarkIlluminaAdapters_red.fox.sh ${i}
#	sleep 30m
done
