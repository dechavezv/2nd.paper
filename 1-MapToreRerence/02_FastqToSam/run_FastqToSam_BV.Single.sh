#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/BV
#$ -l highp,h_rt=27:00:00,h_data=15G,arch=intel*,h_vmem=20G
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/FastqToSam.single.out
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/FastqToSam.single.err
#$ -m abe
#$ -M dechavezv
#$ -N fq2sam

# highmem,highp

# USAGE: qsub ./run_FastqToSam.sh [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

DIR=${1}
cd ${DIR}

mkdir /u/home/d/dechavez/project-rwayne/Clup/reads/BV/temp/${2%.*}
TEMP_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/BV/temp/${2%.*}

java -Xmx12G -jar -Djava.io.tmpdir=${TEMP_DIR} ${PICARD} FastqToSam \
FASTQ=${DIR}/${2} \
OUTPUT=${DIR}/${3} \
READ_GROUP_NAME=${4} \
SAMPLE_NAME=${5} \
LIBRARY_NAME=${6} \
PLATFORM_UNIT=${7} \
PLATFORM=illumina \
SEQUENCING_CENTER=${8} \
TMP_DIR=${TEMP_DIR}
