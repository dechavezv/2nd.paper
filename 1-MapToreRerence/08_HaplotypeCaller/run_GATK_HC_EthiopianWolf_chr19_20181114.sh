#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/ethiopianwolf/EW1
#$ -l h_rt=24:00:00,h_data=22G,arch=intel*
#$ -N HC_EW_19
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-54:1

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
TEMP=/u/flashscratch/j/jarobins/temp
DIR=/u/flashscratch/j/jarobins/ethiopianwolf/EW1

cd /u/home/j/jarobins/project-rwayne/utils/scripts/bam_processing/irnp_pipeline/08_HaplotypeCaller/ethiopianwolf_coords
coords=$(cat $(ls chr19_coords.list_* | head -n ${SGE_TASK_ID} | tail -n 1))

cd ${DIR}
BAM=44_IRNP_ETH2_EW1_T279_HFCKNCCXY_1_Aligned_MarkDuplicates_Filtered_BQSR3_recal.bam
ID=${BAM%_Aligned*}

java -jar -Xmx16g ${GATK} \
-T HaplotypeCaller \
-R ${REFERENCE} \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L ${coords} \
-I ${BAM} \
-o ${ID}_chr19_$(printf %02d $SGE_TASK_ID).g.vcf.gz
