#! /bin/bash

#$ -wd /u/scratch/d/dechavez/QB3ateloc
#$ -l highmem,highp,h_rt=27:00:00,h_data=27G,h_vmem=50G,arch=intel*
#$ -o /u/scratch/d/dechavez/QB3ateloc/log/FastqToSam.out
#$ -e /u/scratch/d/dechavez/QB3ateloc/log/FastqToSam.err
#$ -m abe
#$ -M dechavezv
#$ -N fq2sam

# USAGE: qsub ./run_FastqToSam.sh [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

DIR=${1}
cd ${DIR}

mkdir /u/scratch/d/dechavez/QB3ateloc/temp/${2%.*}
TEMP_DIR=/u/scratch/d/dechavez/QB3ateloc/temp/${2%.*}

java -Xmx27G -jar -Djava.io.tmpdir=${TEMP_DIR} ${PICARD} FastqToSam \
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
