#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project
#$ -l h_rt=24:00:00,h_data=20G,highp
#$ -o /u/scratch/d/dechavez/rails.project/log/MarkIlAd
#$ -e /u/scratch/d/dechavez/rails.project/log/MarkIlAd
#$ -m abe
#$ -M dechavezv
#$ -N MrkIlAd

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/scratch/d/dechavez/rails.project/Jaime.data.2018
TEMP_DIR=/u/scratch/d/dechavez/rails.project/temp
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
