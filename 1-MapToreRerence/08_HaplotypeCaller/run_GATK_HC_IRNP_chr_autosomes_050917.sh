#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/
#$ -l h_rt=24:00:00,h_data=22G,arch=intel*
#$ -t 1-38:1
#$ -N HC_IRNP_43
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp/
BAM=$(ls 43*_BQSR3_recal.bam)
ID=${BAM%_Aligned*}

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L chr$(printf %02d $SGE_TASK_ID) \
-I ${BAM} \
-o /u/scratch2/j/jarobins/irnp/gvcfs/${ID}_chr$(printf %02d $SGE_TASK_ID).g.vcf.gz
