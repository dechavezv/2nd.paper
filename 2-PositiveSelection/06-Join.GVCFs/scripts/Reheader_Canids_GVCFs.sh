#!/bin/bash

#$ -l highp,h_rt=12:00:00,h_data=4G
#$ -pe shared 1
#$ -N Reheader_Canids_GVCFs
#$ -cwd
#$ -m bea
#$ -o ./Reheader_Canids_GVCFs.out
#$ -e ./Reheader_Canids_GVCFs.err
#$ -M dechavezv

# this pipe is better than sed beacuse it doesnt iterate trough every line
# However the tool can be aplied to independet VCF files as well
# for more information got to "https://samtools.github.io/bcftools/bcftools.html"

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load bzip2

for file in Cani*; do (bcftools reheader -s header.txt $file > Reheader_$file && bgzip -c Reheader_$file > Reheader_$file.gz && \
tabix -p vcf Reheader_$file.gz);done
