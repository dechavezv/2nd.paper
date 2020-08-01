#! /bin/bash
#$ -wd /u/scratch/d/dechavez/Croatian/
#$ -l highp,h_rt=12:00:00,h_data=1G
#$ -N subMrkIlAd
#$ -o /u/scratch/d/dechavez/Croatian/log/MkrIlAdp
#$ -e /u/scratch/d/dechavez/Croatian/log/MkrIlAdp
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/03_MarkIlluminaAdapters

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/Croatian

for i in *.bam; do
	$QSUB $SCRIPTDIR/run_MarkIlluminaAdapters_Croatian.sh ${i}
done
