#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l highp,h_rt=14:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/log/reportsfilter.out
#$ -e /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/log/reportsfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/06_RemoveBadReads
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/Lvet 

${QSUB} -N GetUnmapedbam $SCRIPT_DIR/run_GetUnmmaped_Lvet.sh bPgy20_Aligned.MarkDup.bam

##for file in *MarkDup.bam; do
### ${QSUB} -N bamfiltr $SCRIPT_DIR/run_RemoveBadReads_QB3.sh ${file}
##done
