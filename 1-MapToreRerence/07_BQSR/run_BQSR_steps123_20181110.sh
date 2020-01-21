#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/ethiopianwolf/EW1
#$ -l h_rt=48:00:00,h_data=8G,highp
#$ -pe shared 6
#$ -N BQSR
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
TEMP=/u/flashscratch/j/jarobins/temp
DIR=/u/flashscratch/j/jarobins/ethiopianwolf/EW1
INFILE=${1}
FILENAME=${INFILE%_Filtered*}_Filtered
ROUND=${2}

cd ${DIR}


### Step 1: raw genotyping

LOG=${DIR}/${FILENAME}_BQSR${ROUND}_UG.vcf.gz.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${TEMP} ${GATK} \
-T UnifiedGenotyper \
-nt 6 \
-R ${REFERENCE} \
-I ${DIR}/${INFILE} \
-o ${DIR}/${FILENAME}_BQSR${ROUND}_UG.vcf.gz \
-glm BOTH \
--min_base_quality_score 20 \
-metrics ${DIR}/${FILENAME}_BQSR${ROUND}_UG.vcf.gz.metrics &>> ${LOG}

date>>${LOG}


### Step 2: create recalibration table

LOG=${DIR}/${FILENAME}_BQSR${ROUND}_recal.table.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${TEMP} ${GATK} \
-T BaseRecalibrator \
-nct 6 \
-R ${REFERENCE} \
-I ${DIR}/${INFILE} \
-o ${DIR}/${FILENAME}_BQSR${ROUND}_recal.table \
-knownSites ${DIR}/${FILENAME}_BQSR${ROUND}_UG.vcf.gz &>> ${LOG}

date>>${LOG}


### Step 3: recalibrate BAM

LOG=${DIR}/${FILENAME}_BQSR${ROUND}_recal.bam.log

date > ${LOG}

java -jar -Xmx42g -Djava.io.tmpdir=${TEMP} ${GATK} \
-T PrintReads \
-nct 6 \
-R ${REFERENCE} \
-I ${DIR}/${INFILE} \
-o ${DIR}/${FILENAME}_BQSR${ROUND}_recal.bam \
-BQSR ${DIR}/${FILENAME}_BQSR${ROUND}_recal.table &>> ${LOG}

date>>${LOG}




