#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/log/FastqToSam
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_Lvet.sh

DIR=/u/home/d/dechavez/project-rwayne/Lvet

${QSUB} ${SCRIPT} ${DIR} bPve20_1.fastq.gz bPve20_2.fastq.gz bPve20.bam Lvet_1a Lvet Lib1 H2G35CCXY PUCRS
${QSUB} ${SCRIPT} ${DIR} bPgy55_R1.fastq.gz bPgy55_R2.fastq.gz bPgy20.bam Lgy_1a Lgy Lib1 H2G35CCXY PUCRS
${QSUB} ${SCRIPT} ${DIR} bPve20_1_Edited.fastq.gz bPve20_2_Edited.fastq.gz bPve20.Edited.bam Lvet_edit Lvet Lib1 H2G35CCXY PUCRS
