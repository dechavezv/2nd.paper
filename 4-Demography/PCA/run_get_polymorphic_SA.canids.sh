#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF
#$ -l h_rt=24:00:00,h_data=1G,highp
#$ -N OnlySNPs
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
### #$ -t 37-38:1

#echo "Task id is $(printf %02d $SGE_TASK_ID)"

source /u/local/Modules/default/init/modules.sh
module load python
### #> ${Direc}/Filtered/20200530/$1_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf
Direc=/u/scratch/d/dechavez/SA.VCF

cd /u/scratch/d/dechavez/BD/VCF

PREFIX=$1
i=$2
#i=$(printf %02d $SGE_TASK_ID)
zcat ${PREFIX}_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
> ${Direc}/Filtered/20200530/${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf

vcf=${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf

cd ${Direc}/Filtered/20200530

/u/home/d/dechavez/tabix-0.2.6/bgzip -c ${vcf} > ${vcf}.gz
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${vcf}.gz

rm ${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf

#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
#grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

