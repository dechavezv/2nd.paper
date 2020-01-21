#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs
#$ -l h_rt=24:00:00,h_data=21G,arch=intel*
#$ -t 1-38:1
#$ -N GTgVCF_IRNP
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/j/jarobins/irnp/vcfs

java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-allSites \
-stand_call_conf 0 \
-A VariantType \
-A AlleleBalance \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
$(for j in {01..35}_IRNP_*_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz; do echo "-V /u/scratch/j/jarobins/irnp/vcfs/${j} "; done) \
-o /u/scratch/j/jarobins/irnp/vcfs/joint/IRNP_35_joint_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz 

