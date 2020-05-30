#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/TG
#$ -l h_rt=22:00:00,h_data=20G,highp,h_vmem=40G
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/rmBad.out
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/rmBad.err
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load samtools

IN_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/TG
OUT_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/TG

samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam
source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx20g -Djava.io.tmpdir=/u/home/d/dechavez/project-rwayne/Clup/reads/TG/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/TG/temp \
I=${OUT_DIR}/${1%.bam}_Filtered.bam 
