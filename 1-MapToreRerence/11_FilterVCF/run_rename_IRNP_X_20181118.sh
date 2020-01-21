#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=4G,arch=intel*
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -N rename

BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

cd /u/flashscratch/j/jarobins/vcfs

zcat IRNP_44_joint_chrX_TrimAlt_Annot_VEP_Masked.vcf.gz | head -500 | grep "^#" | \
sed 's/UCI_GFO41F/GFO1/g' | \
sed 's/RKW7619/ARC1/g' | \
sed 's/RKW7639/ARC2/g' | \
sed 's/RKW7640/ARC3/g' | \
sed 's/RKW7649/ARC4/g' > head_chrX.txt

zcat IRNP_44_joint_chrX_TrimAlt_Annot_VEP_Masked.vcf.gz | grep -v "^#" | \
cat head_chrX.txt - | \
${BGZIP} > IRNP_44_joint_chrX_TrimAlt_Annot_VEP_Masked_rename.vcf.gz

${TABIX} -p vcf IRNP_44_joint_chrX_TrimAlt_Annot_VEP_Masked_rename.vcf.gz

