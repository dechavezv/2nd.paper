#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf
#$ -l h_rt=24:00:00,h_data=1G,h_vmem=5G
#$ -N OnlySNPs
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/log/
#$ -m abe
#$ -M dechavezv
#$ -t 8-8:1

i=$(printf "%02d" "$SGE_TASK_ID")

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf

zcat Reheader_${i}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' | /u/home/d/dechavez/tabix-0.2.6/bgzip -c \
> onlyPass/Reheader_${i}_FastqToSam.bam_Aligned.MarkDup_Filter_passingSNPs.vcf.gz

vcf=Reheader_${i}_FastqToSam.bam_Aligned.MarkDup_Filter_passingSNPs.vcf.gz

cd onlyPass

#/u/home/d/dechavez/tabix-0.2.6/bgzip -c ${vcf} > ${vcf}.gz
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${vcf}

#rm ${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf


# polymorphic
#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
#grep '1/1\|0/1' > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/LS_joint_allchr_Annot_Mask_Filter_passingSNPs.Scaf.vcf

#Good Quality
# grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
# > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

