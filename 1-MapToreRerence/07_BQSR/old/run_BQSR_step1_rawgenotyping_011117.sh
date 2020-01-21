#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=06:00:00,h_data=2G,highp
#$ -pe shared 12
#$ -N BQSR_s1_r2
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins
#$ -t 20-28:1

source /u/local/Modules/default/init/modules.sh
module load java

# Step 1: raw genotyping

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
IN_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal1
OUT_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal2

cd ${IN_BAM_DIR}

IN_FILE=$(ls $(printf %02d $SGE_TASK_ID)*.bam)

java -jar -Xmx16g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T UnifiedGenotyper \
-nt 12 \
-R ${REFERENCE} \
-I ${IN_BAM_DIR}/${IN_FILE} \
-o ${OUT_BAM_DIR}/${IN_FILE}_BQSR2_UG.vcf.gz \
-glm BOTH \
--min_base_quality_score 20 \
-metrics ${OUT_BAM_DIR}/${IN_FILE}_BQSR2_UG.vcf.gz.metrics 
