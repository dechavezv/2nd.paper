#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/BV
#$ -l highmem,h_rt=28:00:00,h_data=20G,highp,h_vmem=40G
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/AlignClean.out
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/AlignClean.err
#$ -pe shared 2
#$ -m abe
#$ -M dechavezv
#$ -N Align

### #$ -pe shared 4

source /u/local/Modules/default/init/modules.sh
module load java
module load bwa

PICARD=/u/local/apps/picard-tools/current/picard.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31
BAM_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/BV

FILENAME=${1}

TEMP_DIR=/u/scratch/d/dechavez/BD/temp/${FILENAME}

cd ${BAM_DIR}

set -o pipefail

java -Xmx20G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} SamToFastq \
I=${BAM_DIR}/${FILENAME}_MarkIlluminaAdapters.bam \
FASTQ=/dev/stdout \
CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_SamToFastq.txt" | \
bwa mem -M -t 2 -p ${REFERENCE} /dev/stdin 2>>./"Process_"${FILENAME}"_BwaMem.txt" | \
java -Xmx6G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} MergeBamAlignment \
ALIGNED_BAM=/dev/stdin \
UNMAPPED_BAM=${BAM_DIR}/${FILENAME}_FastqToSam.bam \
OUTPUT=${BAM_DIR}/${FILENAME}_Aligned.bam \
R=${REFERENCE}.fa CREATE_INDEX=true \
ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_MergeBam.txt"
