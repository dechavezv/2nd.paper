#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Indv
#$ -l h_rt=24:00:00,h_data=1G,highp
#$ -N OnlySNPs
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-8:1

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/scratch/d/dechavez/rails.project/VCF/Indv

zcat LS$(printf %02d $SGE_TASK_ID)_chrW_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NON_REF" | grep -vE '\./\.' \
> /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/LS$(printf %02d $SGE_TASK_ID)_chrW_Annot_Mask_Filter_passingSNPs.vcf

cd /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc

/u/home/d/dechavez/tabix-0.2.6/bgzip LS$(printf %02d $SGE_TASK_ID)_chrW_Annot_Mask_Filter_passingSNPs.vcf -c > LS$(printf %02d $SGE_TASK_ID)_chrW_Annot_Mask_Filter_passingSNPs.vcf.gz
/u/home/d/dechavez/tabix-0.2.6/tabix LS$(printf %02d $SGE_TASK_ID)_chrW_Annot_Mask_Filter_passingSNPs.vcf.gz

#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
#grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf
