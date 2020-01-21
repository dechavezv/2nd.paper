#! /bin/bash
#$ -wd /u/scratch/j/jarobins/fox
#$ -l h_rt=4:00:00,h_data=32G,highp,exclusive
#$ -N GTgVCFc38t
#$ -o /u/scratch/j/jarobins/fox
#$ -e /u/scratch/j/jarobins/fox
#$ -m abe
#$ -M jarobins
source /u/local/Modules/default/init/modules.sh
module load java
cd /u/scratch/j/jarobins
java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-allSites \
-stand_emit_conf 0 \
-stand_call_conf 0 \
-L chr38 \
$(for j in {01..15}; do echo "-V /u/scratch/j/jarobins/fox/vcfs/fox${j}_GATK_HC_BPR_chr38.g.vcf.gz "; done) \
-o /u/scratch/j/jarobins/fox/vcfs/fox01_15_joint_GATK_HC_BPR_chr38.vcf.gz
