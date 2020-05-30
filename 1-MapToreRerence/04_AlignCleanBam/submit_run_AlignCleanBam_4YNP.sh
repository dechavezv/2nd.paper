#! /bin/bash

#$ -wd /u/scratch/d/dechavez/YNP_4Genomes
#$ -l highp,h_rt=24:00:00,h_data=1G
#$ -N subAlign
#$ -o /u/scratch/d/dechavez/YNP_4Genomes/log/BWA
#$ -e /u/scratch/d/dechavez/YNP_4Genomes/log/BWA
#$ -m abe
#$ -M dechavezv

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam

cd /u/scratch/d/dechavez/YNP_4Genomes

for i in *MarkIlluminaAdapters.bam; do
	FILENAME=${i%_MarkIlluminaAdapters.bam}
	$QSUB $SCRIPTDIR/run_AlignCleanBam_4YNP.sh ${FILENAME}
done
