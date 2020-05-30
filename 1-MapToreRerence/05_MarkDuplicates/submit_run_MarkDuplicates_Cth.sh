#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/MarkDup
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/MarkDup
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/home/d/dechavez/project-rwayne/Cth/reads

#sleep 2h
cd {DIRECT}

for file in *Aligned.bam; do \
${QSUB} -N MarkD${file%_Aligned.bam} $SCRIPTDIR/run_MarkDuplicates_Cth.sh ${file} ${file%.bam}.MarkDup.bam;done
