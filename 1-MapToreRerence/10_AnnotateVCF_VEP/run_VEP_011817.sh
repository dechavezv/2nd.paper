#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/filtered
#$ -l h_rt=48:00:00,h_data=1G,highp
#$ -N foxVEP
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-3:1

source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/project/mcdb/rwayne/jarobins/utils/programs/ensembl-tools-release-87/scripts/variant_effect_predictor
BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/filtered

perl $VEPDIR/variant_effect_predictor.pl --dir $VEPDIR --cache --vcf --offline \
-i fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered.vcf.gz -o STDOUT \
--stats_file fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered_VEP_stats.html \
--sift b --species canis_familiaris --canonical --allow_non_variant --symbol --force_overwrite | \
$BGZIP > fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered_VEP.vcf.gz

$TABIX -p vcf fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_CpGRep_filtered_VEP.vcf.gz
