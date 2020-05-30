#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint/temp
#$ -l h_rt=48:00:00,h_data=2G,highp
#$ -N IRNP_VEP
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/project/mcdb/rwayne/jarobins/utils/programs/ensembl-tools-release-87/scripts/variant_effect_predictor
BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

cd /u/scratch/j/jarobins/irnp/vcfs/joint/temp

perl $VEPDIR/variant_effect_predictor.pl --dir $VEPDIR --cache --vcf --offline \
-i IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt.vcf.gz -o STDOUT \
--stats_file IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_stats.html \
--sift b --species canis_familiaris --canonical --allow_non_variant --symbol --force_overwrite | \
sed 's/ /_/g' | $BGZIP > IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP.vcf.gz

$TABIX -p vcf IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP.vcf.gz
