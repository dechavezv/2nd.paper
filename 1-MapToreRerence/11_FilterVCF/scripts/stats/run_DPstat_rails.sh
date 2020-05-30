#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF
#$ -l highp,h_rt=24:00:00,h_data=15G,highp,h_vmem=20G
#$ -N DP_VCF
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF/log/
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-8:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

export Input=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF
export Out=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF/Stats

java -jar /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa \
--allowMissingData \
-GF DP \
-V ${Input}/$(printf %02d $SGE_TASK_ID)_FastqToSam.bam_Aligned.MarkDup_Filtered.g.vcf.gz.vcf.gz \
-o ${Out}/$(printf %02d $SGE_TASK_ID)_FastqToSam.bam_Aligned.MarkDup_Filtered_DP.table
