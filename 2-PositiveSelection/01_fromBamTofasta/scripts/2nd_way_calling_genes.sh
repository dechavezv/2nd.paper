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


#export BAM=2nd_call_cat_samt_ug_hc_BBJ_raw.vcf.table.bam_chr${i}.bam

export BAM=Masked_depth_vulp.SRR5328113.red.fox.MarkDup_Filtered.bam_d3_phred33.fa 
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Output=/u/home/d/dechavez/project-rwayne/red.fox

## echo -e "\n Getting genome in FASTA format\n"

cd ${Output}

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} | \
bcftools call -c | \
vcfutils.pl vcf2fq -d 3 -D 120 -Q 20 > ${BAM}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM}.fq > ${BAM}_d3_phred33.fa

## #-D 95th percentile of coverage
