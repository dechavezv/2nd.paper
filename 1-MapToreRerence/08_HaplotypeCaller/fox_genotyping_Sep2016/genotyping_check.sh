#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs
#$ -l h_rt=00:20:00,h_data=4G
#$ -N GTstat
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins
#$ -t 3-38:1
for i in {01..15}; do zcat /u/home/j/jarobins/project-rwayne/fox/vcfs/ind_gvcfs/fox${i}_GATK*chr$(printf "%02d" $SGE_TASK_ID)*vcf.gz | wc -l >> /u/home/j/jarobins/project-rwayne/fox/vcfs/check_vcfs/length_chr$(printf "%02d" $SGE_TASK_ID).txt; done

