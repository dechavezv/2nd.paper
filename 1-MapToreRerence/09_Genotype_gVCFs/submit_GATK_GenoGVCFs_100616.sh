#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs
#$ -l h_rt=10:00:00,h_data=21G,highp
#$ -t 1-36:1
#$ -N GTgVCF
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
source /u/local/Modules/default/init/modules.sh
module load java
java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-allSites \
-stand_emit_conf 0 \
-stand_call_conf 0 \
-L chr$SGE_TASK_ID \
$(for j in {01..15}; do echo "-V /u/home/j/jarobins/project-rwayne/fox/vcfs/ind_gvcfs/fox${j}_GATK_HC_BPR_chr$SGE_TASK_ID.g.vcf.gz "; done) \
-o /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/fox01_15_joint_GATK_HC_BPR_chr$SGE_TASK_ID.vcf.gz 

