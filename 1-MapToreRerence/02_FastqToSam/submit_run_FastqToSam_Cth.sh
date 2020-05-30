#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/FastqToSam
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_Cth.sh

DIR=/u/home/d/dechavez/project-rwayne/Cth/reads

${QSUB} ${SCRIPT} ${DIR} bCth-213_S79_L001_R1_001.fastq.gz bCth-213_S79_L001_R2_001.fastq.gz bCth_FastqToSam.bam Cth Lib1 H5THTDSXY UCB
