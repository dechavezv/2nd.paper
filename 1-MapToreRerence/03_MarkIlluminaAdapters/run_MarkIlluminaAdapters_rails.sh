#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
#$ -l h_rt=22:00:00,h_data=10G,highp,h_vmem=30G
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/MarkIlAd.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/MarkIlAd.err
#$ -m abe
#$ -M dechavezv
#$ -N MrkIlAd

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
TEMP_DIR=/u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/temp
PICARD=/u/local/apps/picard-tools/current/picard.jar

cd $DIR

FILENAME=$1

java -Xmx10G -jar -Djava.io.tmpdir=$TEMP_DIR \
${PICARD} \
MarkIlluminaAdapters \
I=${DIR}/$FILENAME \
O=${DIR}/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam \
M=${DIR}/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam_metrics.txt \
TMP_DIR=$TEMP_DIR
