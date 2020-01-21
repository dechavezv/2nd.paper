#! /bin/bash

#$ -wd /u/scratch/d/dechavez/red.fox/raw.reads
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/red.fox/raw.reads/log/FastqToSam
#$ -e /u/scratch/d/dechavez/red.fox/raw.reads/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/scripts/bamTovcf/02_FastqToSam/run_FastqToSam_red.fox.sh

DIR=/u/scratch/d/dechavez/red.fox/raw.reads

for i in {09..13}; do (echo SRR53281${i} && \
${QSUB} ${SCRIPT} ${DIR} SRR53281${i}_1.fastq.gz SRR53281${i}_2.fastq.gz vulp_FastqToSam.SRR53281${i}.bam vulp_1a vulp Lib1 FCD0RD6ACXX Unv_Illlinois);done
