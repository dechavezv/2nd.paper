#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l h_rt=22:00:00,h_data=8G,highp,h_vmem=40G
#$ -N Remv
#$ -o /u/scratch/d/dechavez/IndelReal/log/
#$ -e /u/scratch/d/dechavez/IndelReal/log/
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load samtools

IN_DIR=/u/scratch/d/dechavez/IndelReal
OUT_DIR=/u/scratch/d/dechavez/IndelReal

samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx8g -Djava.io.tmpdir=/u/scratch/d/dechavez/IndelReal/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/scratch/d/dechavez/IndelReal/temp \
I=${OUT_DIR}/${1%.bam}_Filtered.bam
