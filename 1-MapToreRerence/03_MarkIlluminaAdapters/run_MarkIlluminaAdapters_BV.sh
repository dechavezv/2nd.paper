#! /bin/bash
#$ -wd /u/scratch/d/dechavez/YNP_4Genomes
#$ -l h_rt=19:00:00,h_data=8G,highp,h_vmem=20G
#$ -o /u/scratch/d/dechavez/YNP_4Genomes/log/MarkIlAd
#$ -e /u/scratch/d/dechavez/YNP_4Genomes/log/MarkIlAd
#$ -m abe
#$ -M dechavezv
#$ -N MrkIlAd_4YNP

# highmem

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/scratch/d/dechavez/YNP_4Genomes
TEMP_DIR=/u/scratch/d/dechavez/YNP_4Genomes/temp
PICARD=/u/local/apps/picard-tools/current/picard.jar

cd $DIR

FILENAME=$1

java -Xmx8G -jar -Djava.io.tmpdir=$TEMP_DIR \
${PICARD} \
MarkIlluminaAdapters \
I=$DIR/$FILENAME \
O=$DIR/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam \
M=$DIR/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam_metrics.txt \
TMP_DIR=$TEMP_DIR
