#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l h_rt=17:00:00,h_data=20G,highp,h_vmem=34G
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/MarkIlAd
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/MarkIlAd
#$ -m abe
#$ -M dechavezv
#$ -N MrkIlAd

#  highmem
source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/home/d/dechavez/project-rwayne/Cth/reads
TEMP_DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/TG/temp
PICARD=/u/local/apps/picard-tools/current/picard.jar

cd $DIR

FILENAME=$1

java -Xmx18G -jar -Djava.io.tmpdir=$TEMP_DIR \
${PICARD} \
MarkIlluminaAdapters \
I=$DIR/$FILENAME \
O=$DIR/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam \
M=$DIR/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam_metrics.txt \
TMP_DIR=$TEMP_DIR
