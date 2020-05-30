#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF
#$ -l h_rt=24:00:00,h_data=1G,highp
#$ -N OnlySNPs
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python

Direc=/u/scratch/d/dechavez/SA.VCF
cd ${Direc}

zcat $1_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
> ${Direc}/Filtered/20200530/$1_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

cd ${Direc}/Filtered/20200530

/u/home/d/dechavez/tabix-0.2.6/bgzip -c /
$1_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf > $1_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf.gz
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf $1_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf.gz


#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
#grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

