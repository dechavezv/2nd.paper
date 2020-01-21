#! /bin/bash
#$ -wd /u/scratch/j/jarobins/fox
#$ -l h_rt=24:00:00,h_data=21G,arch=intel-E5-2670,highp
#$ -N HC_re22_09
#$ -o /u/scratch/j/jarobins/fox
#$ -e /u/scratch/j/jarobins/fox
#$ -m abe
#$ -M jarobins
source /u/local/Modules/default/init/modules.sh
module load java
cd /u/scratch/j/jarobins
java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-L chr22 \
-I /u/scratch/j/jarobins/fox/bams/fox09*recal.bam \
-o /u/scratch/j/jarobins/fox/vcfs/fox09_GATK_HC_BPR_chr22.g.vcf.gz
