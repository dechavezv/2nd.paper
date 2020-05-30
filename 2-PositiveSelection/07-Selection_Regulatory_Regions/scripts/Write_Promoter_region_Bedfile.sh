#!/bin/bash

#$ -l highp,h_rt=22:00:00,h_data=20G
#$ -pe shared 1
#$ -N BDbychr
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/d/dechavez/GVCFs/BD/log/BDbychr.out
#$ -e /u/flashscratch/d/dechavez/GVCFs/BD/log/BDbychr.err
#$ -M dechavezv
#$ -t 1-38:1
###### $(printf %02d $SGE_TASK_ID)
### highmem

# then load your modules:
. /u/local/Modules/default/init/modules.sh

module load bedtools

export BED=/u/home/d/dechavez/project-rwayne/Besd_Files/Edited_Trascript_Start_end_Canids_all_march6_2019.txt
export chrSize=/u/home/d/dechavez/project-rwayne/Besd_Files/Genome.chr.Length.txt
OUT=/u/flashscratch/d/dechavez/GVCFs

bedtools flank -i ${BED} -g ${chrSize} -l 1000 -r 0 -s > ${OUT}/genes.1kb.promoters.bed
