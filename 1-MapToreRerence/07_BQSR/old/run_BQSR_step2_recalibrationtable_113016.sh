#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=06:00:00,h_data=4G,highp
#$ -pe shared 12
#$ -N BQSR_s2_r2
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-19:1

source /u/local/Modules/default/init/modules.sh
module load java

# Step 2: create recalibration table

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
IN_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal1
OUT_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal2

cd ${IN_BAM_DIR}

IN_FILE=$(ls $(printf %02d $SGE_TASK_ID)*.bam)

java -jar -Xmx42g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T BaseRecalibrator \
-nct 12 \
-R ${REFERENCE} \
-I ${IN_BAM_DIR}/${IN_FILE} \
-o ${OUT_BAM_DIR}/${IN_FILE}_BQSR2_recal.table \
-knownSites ${OUT_BAM_DIR}/${IN_FILE}_BQSR2_UG.vcf.gz
