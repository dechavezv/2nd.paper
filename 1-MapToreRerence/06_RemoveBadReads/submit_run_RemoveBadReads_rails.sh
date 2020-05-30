#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
#$ -l highp,h_rt=22:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/reports
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020

for file in *Aligned.AtlChr.MarkDup.bam; do
	${QSUB} -N bamfiltr${file} $SCRIPT_DIR/run_RemoveBadReads_rails.sh ${file}
done
