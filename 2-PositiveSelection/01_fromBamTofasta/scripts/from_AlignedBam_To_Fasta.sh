#!/bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal/split.bams
#$ -l  highp,h_rt=10:00:00,h_data=1G
#$ -pe shared 1
#$ -N AligbamTofasta
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/IndelReal/split.bams/log/
#$ -e /u/scratch/d/dechavez/IndelReal/split.bams/log/
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load samtools
module load bedtools

export BAM=$1
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Direc=/u/scratch/d/dechavez/IndelReal/split.bams
export data=/u/scratch/d/dechavez/IndelReal/Fasta.files

## echo -e "\n Getting genome in FASTA format\n"

cd ${Direc}

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} |
bcftools call -c |
vcfutils.pl vcf2fq -d 3 -D $2 -Q 20 > ${BAM%.bam}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N {BAM%.bam}.fq > ${data}/${BAM%.bam}.fa

sleep 5h

#rm *.fq
