#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint/annotated
#$ -l h_rt=24:00:00,h_data=12G
#$ -N irnpAnnot
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REF=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/scratch/j/jarobins/irnp/vcfs/joint/annotated

FILE=$(ls *chr$(printf %02d $SGE_TASK_ID)*VEP.vcf.gz)

java -jar -Xmx6g $GATK \
-T VariantAnnotator \
-R $REF \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V ${FILE} \
-o ${FILE%.vcf.gz}_Annot.vcf.gz 
