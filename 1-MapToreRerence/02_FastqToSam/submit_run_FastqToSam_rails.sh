#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/Jaime.data.2018
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/rails.project/log/FastqToSam
#$ -e /u/scratch/d/dechavez/rails.project/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/02_FastqToSam/run_FastqToSam_rails.sh

DIR=/u/scratch/d/dechavez/rails.project/Jaime.data.2018

${QSUB} ${SCRIPT} ${DIR} GR2_S8_L007_R1_001.fastq.gz GR2_S8_L007_R2_001.fastq.gz GR2_S8_HWKG5BBXX_FastqToSam.bam GR2_1a GR2 Lib1 HWKG5BBXX UCLA

#sleep 1h
#sleep 5m

${QSUB} ${SCRIPT} ${DIR} GR5_S9_L007_R1_001.fastq.gz GR5_S9_L007_R2_001.fastq.gz GR5_S9_HWKG5BBXX_FastqToSam.bam GR5_1a GR5 Lib1 HWKG5BBXX UCLA

${QSUB} ${SCRIPT} ${DIR} GR7_S10_L007_R1_001.fastq.gz GR7_S10_L007_R2_001.fastq.gz GR7_S10_HWKG5BBXX_FastqToSam.bam GR7_1a GR7 Lib1 HWKG5BBXX UCLA

${QSUB} ${SCRIPT} ${DIR} GR8_S11_L007_R1_001.fastq.gz GR8_S11_L007_R2_001.fastq.gz GR8_S11_HWKG5BBXX_FastqToSam.bam GR8_1a GR8 Lib1 HWKG5BBXX UCLA

${QSUB} ${SCRIPT} ${DIR} GR9_S12_L007_R1_001.fastq.gz GR9_S12_L007_R2_001.fastq.gz GR9_S12_HWKG5BBXX_FastqToSam.bam GR9_1a GR9 Lib1 HWKG5BBXX UCLA

${QSUB} ${SCRIPT} ${DIR} LS07_S6_L007_R1_001.fastq.gz LS07_S6_L007_R2_001.fastq.gz LS07_S6_HWKG5BBXX_FastqToSam.bam LS07_1a LS07 Lib1 HWKG5BBXX UCLA

${QSUB} ${SCRIPT} ${DIR} LS24_S7_L007_R1_001.fastq.gz LS24_S7_L007_R2_001.fastq.gz LS24_S7_HWKG5BBXX_FastqToSam.bam LS24_1a LS24 Lib1 HWKG5BBXX UCLA
