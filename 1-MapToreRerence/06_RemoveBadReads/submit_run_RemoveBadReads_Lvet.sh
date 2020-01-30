#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Lvet
#$ -l highp,h_rt=14:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/scratch/d/dechavez/Lvet/log/reports.filter.out
#$ -e /u/scratch/d/dechavez/Lvet/log/reports.filter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/Jackal

for file in *MarkDup.bam; do
	${QSUB} -N bamfiltr${file} $SCRIPT_DIR/run_RemoveBadReads_Lvet.sh ${file}
done
