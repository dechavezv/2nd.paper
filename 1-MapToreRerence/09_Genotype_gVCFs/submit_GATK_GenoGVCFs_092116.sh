#! /bin/bash

vcfdir=/u/scratch/j/jarobins/fox/vcfs

#! /bin/bash
#$ -wd /u/scratch/j/jarobins/fox
#$ -l h_rt=24:00:00,h_data=22G
#$ -t 1-36:1
#$ -N GTGVCF
#$ -o /u/scratch/j/jarobins/fox
#$ -e /u/scratch/j/jarobins/fox
#$ -m abe
#$ -M jarobins
source /u/local/Modules/default/init/modules.sh
module load java
cd /u/scratch/j/jarobins/fox
java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-allSites \
-stand_emit_conf 0 \
-stand_call_conf 0 \
-L chr$SGE_TASK_ID \
$(for j in {01..15}; do echo "-V fox${j}_GATK_HC_BPR_chr$SGE_TASK_ID.g.vcf.gz "; done) \
-o fox01_15_joint_GATK_HC_BPR_chr$SGE_TASK_ID.vcf.gz 

