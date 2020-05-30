#! /bin/bash

#$ -wd /u/scratch/d/dechavez/YNP_4Genomes
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/scratch/d/dechavez/YNP_4Genomes/log/MarkDup
#$ -e /u/scratch/d/dechavez/YNP_4Genomes/log/MarkDup
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/YNP_4Genomes

#sleep 2h
cd {DIRECT}

for file in *Aligned.bam; do \
${QSUB} -N MarkD${file%_Aligned.bam} $SCRIPTDIR/run_MarkDuplicates_4YNP.sh ${file} ${file%.bam}.MarkDup.bam;done
