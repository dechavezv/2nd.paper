#! /bin/bash
#$ -wd /u/scratch/d/dechavez/red.fox/raw.reads
#$ -l highmem,h_rt=17:00:00,h_data=20G,highp
#$ -o /u/scratch/d/dechavez/red.fox/raw.reads/log/MarkIlAd
#$ -e /u/scratch/d/dechavez/red.fox/raw.reads/log/MarkIlAd
#$ -m abe
#$ -M dechavezv
#$ -N MrkIlAd

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/scratch/d/dechavez/red.fox/raw.reads
TEMP_DIR=/u/scratch/d/dechavez/red.fox/raw.reads/temp
PICARD=/u/local/apps/picard-tools/current/picard.jar

cd $DIR

FILENAME=$1

java -Xmx17G -jar -Djava.io.tmpdir=$TEMP_DIR \
${PICARD} \
MarkIlluminaAdapters \
I=$DIR/$FILENAME \
O=$DIR/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam \
M=$DIR/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam_metrics.txt \
TMP_DIR=$TEMP_DIR
