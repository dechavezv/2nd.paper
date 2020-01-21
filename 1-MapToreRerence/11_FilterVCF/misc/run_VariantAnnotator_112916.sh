#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=06:00:00,h_data=8G
#$ -N foxAnnot
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-37:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-nightly-2016-11-15-ge744f1e/GenomeAnalysisTK.jar
REF=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates

java -jar $GATK \
-T VariantAnnotator \
-R $REF \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim.vcf.gz \
-o fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz 
