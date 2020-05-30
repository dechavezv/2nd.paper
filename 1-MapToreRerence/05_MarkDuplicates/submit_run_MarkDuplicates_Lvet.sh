#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l highp,h_rt=2:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/log/MarkDup.out
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/log/MarkDup.err
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/home/d/dechavez/project-rwayne/Lvet

cd ${DIRECT}

${QSUB} -N MarkDup01.Human $SCRIPTDIR/run_MarkDuplicates_Lvet.sh bPgy20_Aligned.Homo.bam bPgy20_Aligned.Homo.MarkDup.bam
## ${QSUB} -N MarkDup01_opt2500 $SCRIPTDIR/run_MarkDuplicates_Lvet.sh bPgy20_Aligned.bam bPgy20_Aligned.MarkDup.bam
## ${QSUB} -N MarkDup01_opt2500 $SCRIPTDIR/run_MarkDuplicates_Lvet.sh bPve20_Aligned.bam bPve20_Aligned.MarkDup.bam

## for file in *bam_Aligned*.bam; do
### ${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_Lvet.sh $file Lvet.aligned.MarkDup.bam
