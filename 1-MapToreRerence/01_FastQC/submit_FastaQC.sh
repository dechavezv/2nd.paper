#! /bin/bash

#$ -wd /u/scratch/d/dechavez/BD
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/BD/log/FastqToSam
#$ -e /u/scratch/d/dechavez/BD/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/01_FastQC/run_FastaQC.sh
export DIR=/u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav

cd ${DIR}

${QSUB} ${SCRIPT} ${DIR} Bush-dog_R0902_2_1.fastq.gz Bush-dog_R0902_2_2.fastq.gz BD.bam BD_1a BD Lib1 C7424ACXX Smithsonian
