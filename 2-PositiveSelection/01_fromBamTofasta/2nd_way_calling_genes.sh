#!/bin/bash

#$ -l  highp,h_rt=10:00:00,h_data=1G
#$ -pe shared 1
#$ -N red.fox.neutral
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/red.fox/log/get.neutral.out
#$ -e /u/home/d/dechavez/project-rwayne/red.fox/log/get.neutral.err
#$ -M dechavezv
### #$ -t 1-38:1

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load samtools
module load bedtools
module load python

#i=$(printf %02d $SGE_TASK_ID)
#i=X
#i=$1

#/u/home/d/dechavez/project-rwayne/red.fox/merged.red.fox.filtered.markDup.bam

#export BAM=2nd_call_cat_samt_ug_hc_BBJ_raw.vcf.table.bam_chr${i}.bam
export BAM=Masked_depth_vulp.SRR5328113.red.fox.MarkDup_Filtered.bam_d3_phred33.fa 
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Output=/u/home/d/dechavez/project-rwayne/red.fox
#export neutral=/u/home/d/dechavez/project-rwayne/Besd_Files/Canis_familiaris_all.MT.bed
export neutral=/u/home/d/dechavez/project-rwayne/Besd_Files/neutralLoci-geneFlank10k-sep30k-filtered.bed
#export neutral=/u/home/d/dechavez/project-rwayne/Besd_Files/Canis_familiaris_all.bed
export windows_Phy=/u/home/d/dechavez/project-rwayne/Besd_Files/25kb_Windows_goodQual.bed
## export VCF=BBJ_BQR_BWA_sortRG_rmdup_realign_fixmate_mpileup_allchr_OnlyVariant.vcf

## echo -e "\n Getting genome in FASTA format\n"

cd ${Output}

## samtools mpileup -Q 20 -q 20 -u -v \
## -f ${REF} ${BAM} | \
## bcftools call -c | \
## vcfutils.pl vcf2fq -d 3 -D 120 -Q 20 > ${BAM}.fq
## /u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM}.fq > ${BAM}_d3_phred33.fa

## #-D 95th percentile of coverage

bedtools getfasta -fi ${BAM} -bed ${neutral} -fo ${BAM}.flank10k.fa
mv ${BAM}.flank10k.fa red.fox.neutral.fa
mkdir Gphocs
mv red.fox.neutral.fa Gphocs
cd Gphocs
python ~/project-rwayne/scripts/Python/replaceNames_Fasta_V2.py red.fox.neutral.fa ${neutral} name_
perl -pe 's/\t/_/g' name_red.fox.neutral.fa > Edited.red.fox.neutral.fa
awk -F '_' '/nr/ {F=sprintf("%s.fasta",$2); print > F;next;} {print >> F;}' <  Edited.red.fox.neutral.fa
for file in *.fasta; do (echo $file && mv $file nr_$file);done
rm red.fox.neutral.fa; rm name_red.fox.neutral.fa; rm Edited.red.fox.neutral.fa 

echo -e "\n Finisined process of getting genome in FASTA format\n"

## -aQ33

## cd ${Output}

## samtools mpileup -u -v \
## -f ${REF} ${BAM} | \
## bcftools call -c | \
## vcfutils.pl vcf2fq > ${BAM}.fq
## /u/home/d/dechavez/seqtk/seqtk seq -aQ33 -n N ${BAM}.fq > ${BAM}_phred33.fa
## bedtools getfasta -fi ${BAM}_phred33.fa -bed ${neutral} -fo ${BAM}.MT.fa
## echo -e "\n Finisined process of getting genome in FASTA format\n"

# Use the following for dire wolf

# cd ${Output}

## bcftools mpileup -f ${REF} ${BAM} | \
## bcftools call -mv -Oz -o ${BAM}.vcf.gz
## bcftools index ${BAM}.vcf.gz
## cat ${REF} | bcftools consensus ${BAM}.vcf.gz > ${BAM}.fa

## bedtools getfasta -fi ${BAM}.fa -bed ${neutral} -fo ${BAM}.MT.fa
## echo -e "\n Finisined process of getting genome in FASTA format\n"
