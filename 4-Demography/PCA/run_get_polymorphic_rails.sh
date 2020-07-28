#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf
#$ -l h_rt=60:00:00,h_data=1G,highp
#$ -N OnlySNPs
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/VCF/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf

cat Reheader_allchr_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | grep -vE '\./\.' | \
grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/LS_joint_allchr_Annot_Mask_Filter_passingSNPs.scaf.vcf

# grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
# > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

