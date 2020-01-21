#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/Jaime.data.2018
#$ -l highp,h_rt=20:00:00,h_data=1G
#$ -N subMrkDup
#$ -o /u/scratch/d/dechavez/rails.project/log/MarkDup/
#$ -e /u/scratch/d/dechavez/rails.project/log/MarkDup/
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/05_MarkDuplicates
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
DIRECT=/u/scratch/d/dechavez/rails.project/Jaime.data.2018

#sleep 2h
                                                            
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh GR2_S8_HWKG5BBXX_Aligned.red.crown.bam GR2_S8_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh GR7_S10_HWKG5BBXX_Aligned.red.crown.bam GR7_S10_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh GR9_S12_HWKG5BBXX_Aligned.red.crown.bam GR9_S12_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh LS24_S7_HWKG5BBXX_Aligned.red.crown.bam LS24_S7_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh GR5_S9_HWKG5BBXX_Aligned.red.crown.bam GR5_S9_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh GR8_S11_HWKG5BBXX_Aligned.red.crown.bam GR8_S11_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
${QSUB} -N MarkDup01 $SCRIPTDIR/run_MarkDuplicates_rails.sh LS07_S6_HWKG5BBXX_Aligned.red.crown.bam LS07_S6_HWKG5BBXX_Aligned_MarkDup.red.crown.bam 100
