#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/TG
#$ -l highmem,highp,h_rt=23:00:00,h_data=15G,arch=intel*,h_vmem=20G
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/FastqToSam.out
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/FastqToSam.err
#$ -m abe
#$ -M dechavezv
#$ -N TG.fq2sam

# USAGE: qsub ./run_FastqToSam.sh [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

DIR=${1}
cd ${DIR}

mkdir /u/home/d/dechavez/project-rwayne/Clup/reads/TG/temp/${2%.*}
TEMP_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/TG/temp/${2%.*}

java -Xmx12G -jar -Djava.io.tmpdir=${TEMP_DIR} ${PICARD} FastqToSam \
FASTQ=${DIR}/${2} \
FASTQ2=${DIR}/${3} \
OUTPUT=${DIR}/${4} \
READ_GROUP_NAME=${5} \
SAMPLE_NAME=${6} \
LIBRARY_NAME=${7} \
PLATFORM_UNIT=${8} \
PLATFORM=illumina \
SEQUENCING_CENTER=${9} \
TMP_DIR=${TEMP_DIR}
