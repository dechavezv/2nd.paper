#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=24:00:00,h_data=4G,highp
#$ -pe shared 12
#$ -N BQSRt_s3_2
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

# Step 3: recalibrate BAM

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
BQSR_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal${2}
IN_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/ReadsFiltered

java -jar -Xmx42g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T PrintReads \
-nct 16 \
-R ${REFERENCE} \
-I ${IN_BAM_DIR}/${1} \
-o ${BQSR_DIR}/${1}_BQSR${2}_recal_highp.bam \
-BQSR ${BQSR_DIR}/${1}_BQSR${2}_recal1.table 
