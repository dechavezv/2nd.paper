#! /bin/bash

#$ -wd /u/scratch/d/dechavez/red.fox/raw.reads
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/scratch/d/dechavez/rails.project/log/MarkDup/
#$ -e /u/scratch/d/dechavez/rails.project/log/MarkDup/
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/red.fox/raw.reads/processed.but.low.coverage

#sleep 2h
                                                            
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_red.fox.sh vulp_FastqToSam.SRR5328109.bam_Aligned.red.fox.bam vulp.SRR5328109.red.fox.MarkDup.bam
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_red.fox.sh vulp_FastqToSam.SRR5328110.bam_Aligned.red.fox.bam vulp.SRR5328110.red.fox.MarkDup.bam
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_red.fox.sh vulp_FastqToSam.SRR5328111.bam_Aligned.red.fox.bam vulp.SRR5328111.red.fox.MarkDup.bam
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_red.fox.sh vulp_FastqToSam.SRR5328112.bam_Aligned.red.fox.bam vulp.SRR5328112.red.fox.MarkDup.bam
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_red.fox.sh vulp_FastqToSam.SRR5328113.bam_Aligned.red.fox.bam vulp.SRR5328113.red.fox.MarkDup.bam
