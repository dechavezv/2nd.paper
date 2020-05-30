#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF
#$ -l highp,h_rt=19:00:00,h_data=4G,arch=intel*,h_vmem=20G
#$ -N Hete
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF/log
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF/log
#$ -m abe
#$ -M dechavezv
#$ -t 1-8:1

source /u/local/Modules/default/init/modules.sh
module load python

direc=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/HetPerInd_v8.py

cd ${direc}

VCF=Reheader_$(printf %02d ${SGE_TASK_ID})_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz
Sample=${VCF%_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz}

python ${SCRIPT} ${VCF} > ${Sample}.Hete.GenomWide.txt
