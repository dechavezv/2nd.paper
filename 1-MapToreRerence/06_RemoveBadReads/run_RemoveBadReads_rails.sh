#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
#$ -l highp,highmem,h_rt=18:00:00,h_data=20G,h_vmem=80G,arch=intel*
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/rmBad.out
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/rmBad.err
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load samtools

## SAMTOOLS=/u/home/j/jarobins/project-rwayne/utils/programs/samtools-1.3.1/samtools
IN_DIR=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
OUT_DIR=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam

samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx20g -Djava.io.tmpdir=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/temp \
I=${OUT_DIR}/${1%.bam}_Filtered.bam
