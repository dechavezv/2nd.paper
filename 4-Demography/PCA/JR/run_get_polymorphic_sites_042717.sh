#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/vcfs
#$ -l h_rt=24:00:00,h_data=2G
#$ -N getSNPs
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/home/j/jarobins/project-rwayne/irnp/vcfs

zcat IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_Annot_Masked2.vcf.gz | \
grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_Annot_Masked2_passingSNPs.vcf