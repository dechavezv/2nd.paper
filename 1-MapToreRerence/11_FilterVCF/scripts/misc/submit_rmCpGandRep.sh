#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/fox/vcfs
#$ -l h_rt=24:00:00,h_data=2G
#$ -N fox15_rmCpGandRep
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/fox15_rmCpGandRep.out
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/fox15_rmCpGandRep.err
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1
cd /u/home/j/jarobins/project-rwayne/fox/vcfs
/u/home/j/jarobins/project-rwayne/programs/htslib-1.3.1/tabix -h /u/home/j/jarobins/project-rwayne/fox/vcfs/unfiltered/fox15*.vcf.gz chr$(printf %02d $SGE_TASK_ID) | 
/u/home/j/jarobins/project-rwayne/programs/bedtools2/bin/intersectBed -v -sorted -header -a stdin -b /u/home/j/jarobins/project-rwayne/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed | 
/u/home/j/jarobins/project-rwayne/programs/htslib-1.3.1/bgzip > /u/home/j/jarobins/project-rwayne/fox/vcfs/fox15_UG_q20_emitall_chr$(printf %02d $SGE_TASK_ID)_rmCpGandRepeats.vcf.gz
