#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
#$ -l h_rt=38:00:00,h_data=8G,highp,h_vmem=28G,highmem_forced=TRUE
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/
#$ -pe shared 4
#$ -m abe
#$ -M dechavezv
#$ -N Align

### #$ -pe shared 4

source /u/local/Modules/default/init/modules.sh
module load java
module load bwa

PICARD=/u/local/apps/picard-tools/current/picard.jar
#REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
# REFERENCE=/u/scratch/d/dechavez/rails.project/reference/red.crown.crane/red.cown.crane
#REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/chicken/chicken.GRCg6a.masked.fa
REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa
BAM_DIR=/u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
#BWA_DIR=/u/home/j/jarobins/project-rwayne/utils/programs/bwa-0.7.12

FILENAME=${1}

TEMP_DIR=/u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/temp/${FILENAME}

cd ${BAM_DIR}

set -o pipefail

java -Xmx8G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} SamToFastq \
I=${BAM_DIR}/${FILENAME}_MarkIlluminaAdapters.bam \
FASTQ=/dev/stdout \
CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_SamToFastq.AtlChr.txt" | \
bwa mem -M -t 4 -p ${REFERENCE} /dev/stdin 2>>./"Process_"${FILENAME}"_BwaMem.AtlChr.txt" | \
java -Xmx15G -jar -Djava.io.tmpdir=${TEMP_DIR} \
${PICARD} MergeBamAlignment \
ALIGNED_BAM=/dev/stdin \
UNMAPPED_BAM=${BAM_DIR}/${FILENAME}.FastqToSam.bam \
OUTPUT=${BAM_DIR}/${FILENAME}_Aligned.AtlChr.bam \
R=${REFERENCE} CREATE_INDEX=true \
ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=${TEMP_DIR} 2>>./"Process_"${FILENAME}"_MergeBam.AtlChr.txt"
