#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l highp,h_rt=2:00:00,h_data=1G
#$ -N subSplitBam
#$ -o /u/scratch/d/dechavez/IndelReal/log/subSplitBam
#$ -e /u/scratch/d/dechavez/IndelReal/log/subSplitBam
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/scripts
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/IndelReal

#sleep 2h

cd ${DIRECT}

#for file in *bam; do ${QSUB} -N Splitbam $SCRIPTDIR/run_split_bams.sh $file; done

## ${QSUB} -N Splitbam $SCRIPTDIR/run_split_bams.sh Cb17082018_rmdup_realign_fixmate_Filtered.bam
${QSUB} -N Splitbam $SCRIPTDIR/run_split_bams.sh bsve313_Aligned.MarkDup_Filtered_Indelreal.bam
