#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l h_rt=22:00:00,h_data=20G,highp
#$ -o /u/home/d/dechavez/project-rwayne/Lvet/log/Unmap.out
#$ -e /u/home/d/dechavez/project-rwayne/Lvet/log/Unmap.err
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load samtools

IN_DIR=/u/home/d/dechavez/project-rwayne/Lvet
OUT_DIR=/u/home/d/dechavez/project-rwayne/Lvet

samtools view -hb -f 4 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Unmmaped.bam
source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx14g -Djava.io.tmpdir=/u/home/d/dechavez/project-rwayne/Lvet/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/home/d/dechavez/project-rwayne/Lvet/temp \
I=${OUT_DIR}/${1%.bam}_Unmmaped.bam
