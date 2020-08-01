#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Croatian
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/Croatian/log/FastqToSam
#$ -e /u/scratch/d/dechavez/Croatian/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_Croatian.sh

DIR=/u/scratch/d/dechavez/Croatian


### ${QSUB} ${SCRIPT} ${DIR} bcbr370_S10_R1_001.fastq.gz bcbr370_S10_R2_001.fastq.gz bcbr370_FastqToSam.bam bcbr370 Cbr370 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR2149873_CroatianW_1.fastq.gz  SRR2149873_CroatianW_2.fastq.gz CroatianW_FastqToSam.bam CroatianW_Illum CroatianW Lib1 BRISCOE BGI
