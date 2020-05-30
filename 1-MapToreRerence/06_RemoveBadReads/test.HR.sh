#! /bin/bash

#$ -wd /u/scratch/d/dechavez/NA.Genomes
#$ -l h_rt=32:00:00,h_data=10G,highp,h_vmem=30G,highmem
#$ -q *@n6005
#$ -o /u/scratch/d/dechavez/NA.Genomes/log/rmBad.out
#$ -e /u/scratch/d/dechavez/NA.Genomes/log/rmBad.err
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load samtools

IN_DIR=/u/scratch/d/dechavez/NA.Genomes
OUT_DIR=/u/scratch/d/dechavez/NA.Genomes

#samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam
#source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx10g -Djava.io.tmpdir=/u/scratch/d/dechavez/NA.Genomes/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/scratch/d/dechavez/NA.Genomes/temp \
I=${OUT_DIR}/18_IRNP_CL067_Aligned_MarkDup_Filtered.bam 
