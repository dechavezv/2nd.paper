#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/VCF
#$ -l h_rt=48:00:00,h_data=2G,highp
#$ -N Clup47VEP
#$ -o /u/home/d/dechavez/project-rwayne/Clup/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/VCF/log/reports
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/home/d/dechavez/project-rwayne/ensembl-tools-release-87/scripts/variant_effect_predictor
BGZIP=/u/home/d/dechavez/tabix-0.2.6/bgzip
TABIX=/u/home/d/dechavez/tabix-0.2.6/tabix

cd /u/home/d/dechavez/project-rwayne/Clup/VCF

perl $VEPDIR/variant_effect_predictor.pl --dir $VEPDIR --cache --vcf --offline \
-i NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter.vcf.gz -o STDOUT \
--stats_file NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP_stats.html \
--sift b --species canis_familiaris --canonical --allow_non_variant --symbol --force_overwrite | \
sed 's/ /_/g' | $BGZIP > NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz

$TABIX -p vcf NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz
