#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp
#$ -l h_rt=24:00:00,h_data=22G,arch=intel*
#$ -N HCgfox
#$ -o /u/home/j/jarobins/project-rwayne/reports/
#$ -e /u/home/j/jarobins/project-rwayne/reports/
#$ -m abe
#$ -M jarobins
#$ -t 1-124:1

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch2/j/jarobins/irnp
BAM=${1}
ID=${BAM%_chrX.bam}

COORDS=$(cat /u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/fox_pipeline/freebayes/coordinates/grayfox_chrX_1Mb/chrX_$(printf %03d $SGE_TASK_ID).txt)

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L ${COORDS} \
-I ${BAM} \
-o ${ID}_chrX_$(printf %03d $SGE_T