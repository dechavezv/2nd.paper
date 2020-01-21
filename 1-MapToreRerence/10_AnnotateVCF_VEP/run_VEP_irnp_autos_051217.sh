#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=48:00:00,h_data=2G,highp
#$ -N VEPirnp
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/project/mcdb/rwayne/jarobins/utils/programs/ensembl-tools-release-87/scripts/variant_effect_predictor
BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

cd /u/scratch2/j/jarobins/irnp/joint_vcfs

perl $VEPDIR/variant_effect_predictor.pl --dir $VEPDIR --cache --vcf --offline \
-i IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz -o STDOUT \
--stats_file IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP_stats.html \
--sift b --species canis_familiaris --canonical --allow_non_variant --symbol --force_overwrite | \
sed 's/ /_/g' | sed 's/<NON_REF>/N/g' | sed -E 's/\t\t/\t.\t/g' | \
$BGZIP > IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP.vcf.gz

$TABIX -p vcf IRNP_43_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_VEP.vcf.gz
