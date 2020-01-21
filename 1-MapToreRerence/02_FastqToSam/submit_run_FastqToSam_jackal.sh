#! /bin/bash

#$ -wd /u/scratch/d/dechavez/jackal
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/jackal/log/FastqToSam
#$ -e /u/scratch/d/dechavez/jackal/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/02_FastqToSam/run_FastqToSam_red.fox.sh

DIR=/u/home/d/dechavez/project-rwayne/Jackal

${QSUB} ${SCRIPT} ${DIR} SRR8049192_1.fastq.gz SRR8049192_2.fastq.gz Caur_FastqToSam.bam Caur_1a Caur Lib1 C4PCGANXX Unv_Copenhagen
