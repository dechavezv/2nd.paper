#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
#$ -l highp,h_rt=140:00:00,h_data=24G,highp,h_vmem=40G
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/GTgVCF.out
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/GTgVCF.err
#$ -m abe
#$ -M dechavezv

#

export Gvcf=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
export VCF=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/VCF
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
export temp=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/temp

cd ${Gvcf}

source /u/local/Modules/default/init/modules.sh
module load java

IDX=$1
vcfFile=${IDX%.g.vcf.gz}

/u/home/d/dechavez/project-rwayne/gatk-4.1.5.0/gatk --java-options "-Xmx24G" \
GenotypeGVCFs \
-R ${Reference} \
-V ${Gvcf}/${IDX} \
-O ${VCF}/${IDX}.vcf.gz \
--tmp-dir=${temp} \
--standard-min-confidence-threshold-for-calling 00.0 \
--include-non-variant-sites
