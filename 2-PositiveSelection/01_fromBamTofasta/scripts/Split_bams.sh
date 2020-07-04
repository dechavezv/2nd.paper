#!/bin/bash

#$ -l highmem,highp,h_rt=26:00:00,h_data=5G
#$ -cwd
#$ -N SplitBam.red.fox
#$ -m bea
#$ -o /u/scratch/d/dechavez/IndelReal/log/SplitBam.out
#$ -e /u/scratch/d/dechavez/IndelReal/log/SplitBam.err
#$ -M dechavezv
#$ -t 1-38:1

i=$(printf %02d $SGE_TASK_ID)
#i=X
#i=MT


export BAM=$1
export Input=/u/scratch/d/dechavez/IndelReal
export Output=/u/scratch/d/dechavez/IndelReal/split.bams

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load samtools

samtools view -hb ${Input}/${BAM} chr$i > ${Output}/${BAM}_chr$i.bam
samtools index ${Output}/${BAM}_chr$i.bam
