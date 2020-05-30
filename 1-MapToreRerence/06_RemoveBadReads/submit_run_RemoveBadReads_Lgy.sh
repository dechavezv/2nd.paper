#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet/Lgy
#$ -l highp,h_rt=10:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/Lgy/log/bamfilter.out
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/Lgy/log/bamfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/Lvet/Lgy

for file in *MarkDup_Filtered.bam; do
${QSUB} -N bamfiltr $SCRIPT_DIR/run_RemoveBadReads_Lgy.sh ${file}
done
