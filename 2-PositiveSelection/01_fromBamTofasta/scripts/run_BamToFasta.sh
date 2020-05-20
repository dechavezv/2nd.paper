#!/bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal/split.bams
#$ -l h_rt=10:00:00,h_data=2G,h_vmem=18G
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
export neutral=/u/home/d/dechavez/project-rwayne/Besd_Files/neutralLoci-geneFlank10k-sep30k-filtered.bed
export windows=/u/home/d/dechavez/project-rwayne/Besd_Files/25kb_Windows_goodQual.bed


cd ${Direc}

echo -e "\n Getting genome in FASTA format for $1\n"
samtools mpileup -Q 30 -q 30 -u -v \
-f ${REF} ${BAM} |
bcftools call -c |
vcfutils.pl vcf2fq -d 2 -D $2 -Q 30 > ${BAM%.bam}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM%.bam}.fq > ${BAM%.bam}.fa
echo -e "\n Done with FASTA format for $1\n"

## echo -e "\n Getting regions for $1\n"
## bedtools getfasta -fi ${BAM%.bam}.fa -bed ${neutral} -fo ${data}/${BAM}.geneFlank10k.fa
## bedtools getfasta -fi ${BAM%.bam}.fa -bed ${windows} -fo ${data}/${BAM}.25kb.fa
## echo -e "\n Done with regions for $1\n"

#rm *.fq