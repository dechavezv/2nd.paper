#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/Jaime.data.2018
#$ -l highp,h_rt=06:00:00,h_data=1G
#$ -N subMrkIlAd
#$ -o /u/scratch/d/dechavez/rails.project/log/MkrIlAdp
#$ -e /u/scratch/d/dechavez/rails.project/log/MkrIlAdp
#$ -m abe
#$ -M dechavezv


SCRIPTDIR=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/03_MarkIlluminaAdapters

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/rails.project/Jaime.data.2018

for i in ./*bam; do
	$QSUB $SCRIPTDIR/run_MarkIlluminaAdapters_rails.sh ${i}
#	sleep 30m
done
