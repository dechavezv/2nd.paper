#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
#$ -l highp,h_rt=22:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/reports
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/reports
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam

for file in *Aligned.AtlChr.MarkDup.bam; do
	${QSUB} -N bamfiltr${file} $SCRIPT_DIR/run_RemoveBadReads_rails.sh ${file}
done
