#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp
#$ -l h_rt=12:00:00,h_data=5G,highp
#$ -pe shared 9
#$ -N BQSR_s3_r3
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins

# NOTE: Need to carefully manage disk space usage!!!

source /u/local/Modules/default/init/modules.sh
module load java

# Step 3: recalibrate BAM

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
IN_BAM_DIR=/u/scratch2/j/jarobins/irnp
OUT_BAM_DIR=/u/scratch2/j/jarobins/irnp

ROUND=3

cd ${IN_BAM_DIR}

IN_FILE=9_libA_gjtel_RKW1332_nodupmaptrim.bam_BQSR1_recal.bam_BQSR2_recal.bam

java -jar -Xmx38g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T PrintReads \
-nct 9 \
-R ${REFERENCE} \
-I ${IN_BAM_DIR}/${IN_FILE} \
-o ${OUT_BAM_DIR}/${IN_FILE}_BQSR${ROUND}_recal.bam \
-BQSR ${OUT_BAM_DIR}/${IN_FILE}_BQSR${ROUND}_recal.table
