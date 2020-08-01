#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Croatian
#$ -l h_rt=80:00:00,h_data=4G,highp,h_vmem=80G
#$ -o /u/scratch/d/dechavez/Croatian/log/AlignClean.out
#$ -e /u/scratch/d/dechavez/Croatian/log/AlignClean.err
#$ -pe shared 12
#$ -m abe
#$ -M dechavezv
#$ -N Align

### #$ -pe shared 4
#highmem

source /u/local/Modules/default/init/modules.sh
module load java
module load bwa

PICARD=/u/local/apps/picard-tools/current/picard.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31
BAM_DIR=/u/scratch/d/dechavez/Croatian

FILENAME=${1}

TEMP_DIR=/u/scratch/d/dechavez/IberianChinese/temp/${FILENAME}

cd ${BAM_DIR}

set -o pipefail

java -Xmx4G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} SamToFastq \
I=${BAM_DIR}/${FILENAME}_MarkIlluminaAdapters.bam \
FASTQ=/dev/stdout \
CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_SamToFastq.txt" | \
bwa mem -M -t 12 -p ${REFERENCE} /dev/stdin 2>>./"Process_"${FILENAME}"_BwaMem.txt" | \
java -Xmx4G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} MergeBamAlignment \
ALIGNED_BAM=/dev/stdin \
UNMAPPED_BAM=${BAM_DIR}/${FILENAME}_FastqToSam.bam \
OUTPUT=${BAM_DIR}/${FILENAME}_Aligned.bam \
R=${REFERENCE}.fa CREATE_INDEX=true \
ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_MergeBam.${FILENAME}.txt"
