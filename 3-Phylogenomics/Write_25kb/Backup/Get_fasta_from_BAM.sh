#!/bin/bash

#Use the following script to transform you bam file to fasta file
#This only transformed chr1 but you can parallilized to do each chr separetly

#$ -l highp,h_rt=20:00:00,h_data=4G
#$ -pe shared 1
#$ -N ENSCAFG00000032767
#$ -cwd
#$ -m bea
#$ -o ./ENSCAFG00000032767_HD.out
#$ -e ./ENSCAFG00000032767_HD.err
#$ -M dechavezv


# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools/1.2 
module load samtools/1.2
module load bedtools/2.26.0

export BAM=/u/scratch/d/dechavez/African/2nd_call_cat_samt_ug_hc_fb_Wildog_raw_Reheader.vcf.table.bam
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Output=/u/scratch/d/dechavez/African
export BED=/u/home/d/dechavez/project-rwayne/Besd_Files/Canis_familiaris_all.bed  

cd ${Output}

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} |
bcftools call -c |
vcfutils.pl vcf2fq -d 4 -D <95th percentile Total coverage> -Q 20 > ${BAM}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM}.fq > ${BAM}_d4_D<95th>_phred33.fa
bedtools getfasta -fi ${BAM}.fa -bed ${BED} -fo ${BAM}_25kb.fa
