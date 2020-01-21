#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/process
#$ -l h_rt=12:00:00,h_data=8G,highp
#$ -pe shared 6
#$ -N BQSR_s2_r3
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins
#$ -t 39-43:1

source /u/local/Modules/default/init/modules.sh
module load java

# Step 2: create recalibration table

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

ROUND=3

cd /u/scratch2/j/jarobins/process

IN_FILE=$(ls $(printf %02d $SGE_TASK_ID)*BQSR2_recal.bam)

java -jar -Xmx42g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T BaseRecalibrator \
-nct 6 \
-R ${REFERENCE} \
-I ${IN_FILE} \
-o ${IN_FILE}_BQSR${ROUND}_recal.table \
-knownSites ${IN_FILE}_BQSR${ROUND}_UG.vcf.gz
