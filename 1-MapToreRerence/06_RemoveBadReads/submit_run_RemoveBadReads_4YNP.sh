#! /bin/bash

#$ -wd /u/scratch/d/dechavez/YNP_4Genomes
#$ -l h_rt=4:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/scratch/d/dechavez/YNP_4Genomes/log/reportsfilter.out
#$ -e /u/scratch/d/dechavez/YNP_4Genomes/log/reportsfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/YNP_4Genomes

for file in *MarkDup.bam; do
${QSUB} -N bamfiltr $SCRIPT_DIR/run_RemoveBadReads_4YNP.sh ${file}
done
