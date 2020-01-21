#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=12G
#$ -N addAnnot
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load java


GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REF=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/scratch2/j/jarobins/irnp/joint_vcfs

FILE=$(ls *chr$(printf %02d $SGE_TASK_ID)*TrimAlt.vcf.gz)

java -jar -Xmx8g $GATK \
-T VariantAnnotator \
-R $REF \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V ${FILE} \
-o ${FILE%.vcf.gz}_Annot.vcf.gz 
