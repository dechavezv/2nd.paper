#! /bin/bash

#$ -wd /u/scratch/d/dechavez/red.fox/raw.reads
#$ -l highmem,h_rt=28:00:00,h_data=8G,highp
#$ -o /u/scratch/d/dechavez/red.fox/raw.reads/log/AlignClean.out
#$ -e /u/scratch/d/dechavez/red.fox/raw.reads/log/AlignClean.err
#$ -pe shared 4
#$ -m abe
#$ -M dechavezv
#$ -N Align

### #$ -pe shared 4

source /u/local/Modules/default/init/modules.sh
module load java
module load bwa

PICARD=/u/local/apps/picard-tools/current/picard.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31
BAM_DIR=/u/scratch/d/dechavez/red.fox/raw.reads
#BWA_DIR=/u/home/j/jarobins/project-rwayne/utils/programs/bwa-0.7.12

FILENAME=${1}

TEMP_DIR=/u/scratch/d/dechavez/rails.project/temp/${FILENAME}

cd ${BAM_DIR}

set -o pipefail

java -Xmx6G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} SamToFastq \
I=${BAM_DIR}/${FILENAME}_MarkIlluminaAdapters.bam \
FASTQ=/dev/stdout \
CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_SamToFastq.red.fox.txt" | \
bwa mem -M -t 4 -p ${REFERENCE} /dev/stdin 2>>./"Process_"${FILENAME}"_BwaMem.red.fox.txt" | \
java -Xmx6G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} MergeBamAlignment \
ALIGNED_BAM=/dev/stdin \
UNMAPPED_BAM=${BAM_DIR}/${FILENAME} \
OUTPUT=${BAM_DIR}/${FILENAME}_Aligned.red.fox.bam \
R=${REFERENCE}.fa CREATE_INDEX=true \
ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_MergeBam.red.fox.txt"
