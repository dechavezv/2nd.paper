#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/process
#$ -l h_rt=24:00:00,h_data=8G,highp
#$ -pe shared 4
#$ -N BQSR_s3_r2
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins
#$ -t 39-43:1

# NOTE: Need to carefully manage disk space usage!!!

source /u/local/Modules/default/init/modules.sh
module load java

# Step 3: recalibrate BAM

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

ROUND=2

cd /u/scratch2/j/jarobins/process

IN_FILE=$(ls $(printf %02d $SGE_TASK_ID)*BQSR1_recal.bam)

java -jar -Xmx26g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T PrintReads \
-nct 4 \
-R ${REFERENCE} \
-I ${IN_FILE} \
-o ${IN_FILE}_BQSR${ROUND}_recal.bam \
-BQSR ${IN_FILE}_BQSR${ROUND}_recal.table
