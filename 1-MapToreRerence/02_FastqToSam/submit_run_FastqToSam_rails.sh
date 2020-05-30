#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/FastqToSam
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/02_FastqToSam/run_FastqToSam_rails.sh

DIR=/u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020


#sleep 1h
#sleep 5m

## ${QSUB} ${SCRIPT} ${DIR} GR5_S9_L007_R1_001.fastq.gz GR5_S9_L007_R2_001.fastq.gz GR5_S9_HWKG5BBXX_FastqToSam.bam GR5_1a GR5 Lib1 HWKG5BBXX UCLA
## ${QSUB} ${SCRIPT} ${DIR} LS05_S80_L001_R1_001.fastq.gz LS05_S80_L001_R2_001.fastq.gz LS05.FastqToSam.bam LS051a LS05 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS09_S81_L001_R1_001.fastq.gz LS09_S81_L001_R2_001.fastq.gz LS09.FastqToSam.bam LS091a LS09 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS21_S82_L001_R1_001.fastq.gz LS21_S82_L001_R2_001.fastq.gz LS21.FastqToSam.bam LS221a LS21 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS29_S83_L001_R1_001.fastq.gz LS29_S83_L001_R2_001.fastq.gz LS29.FastqToSam.bam LS291a LS29 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS34_S84_L001_R1_001.fastq.gz LS34_S84_L001_R2_001.fastq.gz LS34.FastqToSam.bam LS341a LS34 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS35_S85_L001_R1_001.fastq.gz LS35_S85_L001_R2_001.fastq.gz LS35.FastqToSam.bam LS351a LS35 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS49_S86_L001_R1_001.fastq.gz LS49_S86_L001_R2_001.fastq.gz LS49.FastqToSam.bam LS491a LS49 Lib1 H5THTDSXY UCB_QB3
${QSUB} ${SCRIPT} ${DIR} LS57_S87_L001_R1_001.fastq.gz LS57_S87_L001_R2_001.fastq.gz LS57.FastqToSam.bam LS571a LS57 Lib1 H5THTDSXY UCB_QB3
