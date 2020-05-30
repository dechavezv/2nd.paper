#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF
#$ -l h_rt=24:00:00,h_data=1G,highp
#$ -N OnlySNPs
#$ -o /u/scratch/d/dechavez/rails.project/VCF/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 3-3:1

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/scratch/d/dechavez/rails.project/VCF

zcat LS_joint_chr$(printf $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

# grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
# > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

