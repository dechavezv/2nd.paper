#!/bin/bash

#$ -wd u/scratch/d/dechavez/IndelReal/split.bams
#$ -l highmem,highp,h_rt=10:00:00,h_data=15G,h_vmem=44G
#$ -N AligbamTofasta
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/IndelReal/Fasta.files/log/
#$ -e /u/scratch/d/dechavez/IndelReal/Fasta.files/log/
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load samtools
module load bedtools
module load python

export BAM=$1
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Direc=/u/scratch/d/dechavez/IndelReal/split.bams
export data=/u/scratch/d/dechavez/IndelReal/Fasta.files
export neutral=/u/home/d/dechavez/project-rwayne/Besd_Files/neutralLoci-geneFlank10k-sep30k-filtered.bed
export windows=/u/home/d/dechavez/project-rwayne/Besd_Files/25kb_Windows_goodQual.bed


cd ${Direc}

echo -e "\n Getting genome in FASTA format for $1\n"

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} |
bcftools call -c |
vcfutils.pl vcf2fq -d 4 -D $2 -Q 20 > ${BAM%.bam}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM%.bam}.fq > ${BAM%.bam}.fa
python /u/home/d/dechavez/project-rwayne/scripts/Python/lowercase_to_N.py ${BAM%.bam}.fa
rm ${BAM%.bam}.fa
mv Masked_depth_${BAM%.bam}.fa ${BAM%.bam}.fa

echo -e "\n Done with FASTA format for $1\n"

echo -e "\n Getting regions for $1\n"
bedtools getfasta -fi ${BAM%.bam}.fa -bed ${neutral} -fo ${data}/${BAM}.geneFlank10k.fa
bedtools getfasta -fi ${BAM%.bam}.fa -bed ${windows} -fo ${data}/${BAM}.25kb.fa
echo -e "\n Done with regions for $1\n"

#rm *.fq
