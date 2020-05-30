#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/vcfs/sift/lroh_annotated
#$ -l h_rt=24:00:00,h_data=8G
#$ -N VEPvarParse
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/home/j/jarobins/project-rwayne/irnp/vcfs/sift/lroh_annotated

INPUT=${1}
SAMPLES=${2}

java -jar -Xmx4g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-V ${INPUT} \
-o ${INPUT%.vcf.gz}_${SAMPLES%.txt}.vcf.gz \
--sample_file ${SAMPLES} \
-keepOriginalAC -keepOriginalDP
