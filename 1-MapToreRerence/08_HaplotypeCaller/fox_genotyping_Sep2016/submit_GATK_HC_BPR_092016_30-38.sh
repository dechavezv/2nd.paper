#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne
#$ -l h_rt=24:00:00,h_data=32G
#$ -N HC_fox15_38
#$ -o /u/scratch/j/jarobins/HC_fox15_38.out
#$ -e /u/scratch/j/jarobins/HC_fox15_38.err
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
-stand_emit_conf 0 \
-stand_call_conf 0 \
-L chr38 \
-I /u/scratch/j/jarobins/fox/bams/fox15*recal.bam \
-o /u/scratch/j/jarobins/fox/vcfs/fox15_GATK_HC_BPR_chr38.g.vcf.gz
