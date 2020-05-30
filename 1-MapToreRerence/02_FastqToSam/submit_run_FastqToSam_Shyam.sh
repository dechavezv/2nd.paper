#! /bin/bash

#$ -wd /u/scratch/d/dechavez/BD
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/FastqToSam
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_Shyam.sh

DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/TG


${QSUB} ${SCRIPT} ${DIR} SRR8049197_WGS_of_GreyWolf_Ellesmere1_muscle_1.fastq.gz SRR8049197_WGS_of_GreyWolf_Ellesmere1_muscle_2.fastq.gz SRR8049197_GreyWolf_Ellesmere.bam Clup_SRR8049197  Lib1 FCC79F2ACXX Unv.Copenhagen

${QSUB} ${SCRIPT} ${DIR} SRR8049200_WGS_of_GreyWolf_MexicanWolf_muscle_1.fastq.gz SRR8049200_WGS_of_GreyWolf_MexicanWolf_muscle_2.fastq.gz SRR8049200_GreyWolf_MexicanWolf.bam Cruf_SRR8049200 Lib1 C4PU7ANXX Unv.Copenhagen
