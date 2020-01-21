#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=20:00:00,h_data=4G,highp
#$ -pe shared 12
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

cd ${IN_BAM_DIR}

IN_FILE=$(ls $(printf %02d ${1})*Aligned_MarkDup_Filtered.bam)

java -jar -Xmx42g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T PrintReads \
-nct 16 \
-R ${REFERENCE} \
-I ${IN_BAM_DIR}/${IN_FILE} \
-o ${BQSR_DIR}/${IN_FILE}_BQSR${2}_recal.bam \
-BQSR ${BQSR_DIR}/${IN_FILE}_BQSR${2}_recal.table 
