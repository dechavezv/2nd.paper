#!/bin/bash

#$ -l h_rt=23:00:00,h_data=2G
#$ -cwd
#$ -N SplitBam
#$ -m bea
#$ -o /u/scratch/d/dechavez/IndelReal/log/
#$ -e /u/scratch/d/dechavez/IndelReal/log/
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
