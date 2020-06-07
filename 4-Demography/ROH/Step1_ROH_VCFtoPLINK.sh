#! /bin/bash

#$ -cwd
#$ -l h_rt=04:00:00,h_data=8G,highp,h_vmem=30G,highmem_forced=TRUE
#$ -N plinkROH
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38

# highmem 

# vcftools LROH requires >1 individual
# plink doesn't

source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

# need to get chr name from file
i=$(printf "%02d" "$SGE_TASK_ID")
Sample=$1
wd=/u/scratch/d/dechavez/SA.VCF/Filtered/20200530
vcf=${Sample%.txt}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz

# convert to ped/map format. note that you lose chromosome info - that's a pain.
plinkindir=$wd/plinkInputFiles
plinkoutdir=$wd/plinkOutputFiles
mkdir -p $plinkindir

vcftools --gzvcf $vcf --plink --chr chr$i --out $plinkindir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
