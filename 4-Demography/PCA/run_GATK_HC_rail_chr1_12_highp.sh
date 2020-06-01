#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF                                          
#$ -l h_rt=142:00:00,h_data=1G,highp,h_vmem=10G
#$ -t 37-38:1
#$ -N OnlySNPs 
#$ -o /u/scratch/d/dechavez/SA.VCF/log/                                          
#$ -e /u/scratch/d/dechavez/SA.VCF/log/                                          
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load python

Direc=/u/scratch/d/dechavez/SA.VCF
cd ${Direc}
i=$(printf %02d $SGE_TASK_ID)
echo $i

#zcat $1_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter.vcf.gz | \
#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
#> ${Direc}/Filtered/20200530/$1_chr$(printf %02d $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

/u/home/d/dechavez/tabix-0.2.6/bgzip -c Sve338_chr${i}_Annot_Mask_Filter_passingSNPs.vcf > Sve338_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf Sve338_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz
