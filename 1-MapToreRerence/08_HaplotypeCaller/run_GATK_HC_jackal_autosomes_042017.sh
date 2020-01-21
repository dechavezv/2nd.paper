#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp
#$ -l h_rt=24:00:00,h_data=22G,arch=intel*
#$ -t 1-38:1
#$ -N HCjackal
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp
BAM=9_libA_gjtel_RKW1332_nodupmaptrim.bam_BQSR1_recal.bam_BQSR2_recal.bam_BQSR3_recal.bam
ID=9_libA_gjtel_RKW1332

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L chr$(printf %02d $SGE_TASK_ID) \
-I ${BAM} \
-o ${ID}_chr$(printf %02d $SGE_TASK_ID).g.vcf.gz
