#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/VCF 
#$ -l h_rt=24:00:00,h_data=2G
#$ -N OnlySNPs
#$ -o /u/home/d/dechavez/project-rwayne/Clup/VCF/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/VCF/log/reports
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/home/d/dechavez/project-rwayne/Clup/VCF

zcat NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > NA_CLup_joint_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf
