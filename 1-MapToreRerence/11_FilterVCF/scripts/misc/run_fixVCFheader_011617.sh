#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=12:00:00,h_data=4G
#$ -N vcfheadfix
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-37:1

BGZIP=/u/project/mcdb/rwayne/jarobins/utils/programs/htslib-1.3.1/bgzip

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/AddAnnotations

zcat fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot.vcf.gz | \
sed 's/##FILTER=<ID=LowQual,Description="Low quality">/##FILTER=<ID=LowQual,Description="Low quality">\n##FILTER=<ID=FAIL_refN,Description="Low quality">\n##FILTER=<ID=FAIL_bad_alt,Description="Low quality">\n##FILTER=<ID=FAIL_QUAL,Description="Low quality">\n##FILTER=<ID=FAIL_bad_mut,Description="Low quality">\n##FILTER=<ID=FAIL_DP,Description="Low quality">\n##FILTER=<ID=FAIL_altstrand,Description="Low quality">\n##FILTER=<ID=FAIL_missing,Description="Low quality">\n##FILTER=<ID=FAIL_excesshet,Description="Low quality">/g' | \
$BGZIP > fox_15_joint_chr$(printf %02d $SGE_TASK_ID)_trim_annot_newheader.vcf.gz
