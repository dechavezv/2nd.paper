#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs
#$ -l h_rt=24:00:00,h_data=2G
#$ -N checkCpG
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/checkCpGfilter.out
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/checkCpGfilter.err
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

cd /u/home/j/jarobins/project-rwayne/fox/vcfs
for i in {01..15}; do zcat fox${i}*chr$(printf %02d $SGE_TASK_ID)*ts.vcf.gz | wc -l >> linecounts_chr$(printf %02d $SGE_TASK_ID).txt; done
