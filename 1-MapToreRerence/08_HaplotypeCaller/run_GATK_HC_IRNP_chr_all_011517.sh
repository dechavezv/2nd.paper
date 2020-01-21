#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/
#$ -l h_rt=24:00:00,h_data=22G,arch=intel*
#$ -t 29-35:1
#$ -N HC_IRNP_X
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/j/jarobins/irnp/bams/BQSR/recal3/
BAM=$(ls $(printf %02d $SGE_TASK_ID)*_BQSR3_recal.bam)
ID=${BAM%_Aligned_MarkDup_Filtered.bam_BQSR1_recal.bam_BQSR2_recal.bam_BQSR3_recal.bam}

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L chrX \
-I ${BAM} \
-o /u/scratch/j/jarobins/irnp/vcfs/${ID}_chrX.g.vcf.gz
