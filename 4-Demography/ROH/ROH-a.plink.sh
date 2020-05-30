#! /bin/bash

#$ -cwd
#$ -l h_rt=04:00:00,h_data=8G,highp,h_vmem=30G,highmem_forced=TRUE
#$ -N plinkROH
#$ -o /u/scratch/d/dechavez/BD/ROH/log/BD.plink.out
#$ -e /u/scratch/d/dechavez/BD/ROH/log/BD.plink.err
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
#i=39
Sample=$1
wd=/u/scratch/d/dechavez/BD/ROH
vcf=/u/scratch/d/dechavez/BD/ROH/bsve_joint_chr${i}_TrimAlt_Annot_Mask_Filter_${Sample%.txt}.vcf.gz

# convert to ped/map format. note that you lose chromosome info - that's a pain.
plinkindir=$wd/plinkInputFiles
plinkoutdir=$wd/plinkOutputFiles
mkdir -p $plinkoutdir
mkdir -p $plinkindir
vcftools --gzvcf $vcf --plink --chr chr$i --out $plinkindir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink

# use plink:
# defaults (also cite MacQuillan 2008)
# sliding window is 5000kb, 50 snps
# window allows 5 missing calls, 1 het call
# 1000kb min length and >100 variants for a ROH --> CHANGING this to 500kb and >50 variants ala MacQuillan 
# at least 1 variant per 50kb
# http://zzz.bwh.harvard.edu/plink/ibdibs.shtml
# http://www.sciencedirect.com/science/article/pii/S000292970800445X
#plink \
#--file $plinkindir/01_Elut_CA_Gidget.raw_variants.${i}.${date}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink \
#--homozyg \
#--out $plinkoutdir/01_Elut_CA_Gidget.raw_variants.${i}.${date}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
# try with more missing allowed: 30 missing
#plinkoutdir2=$wd/plinkOutputFiles-30missing/

#Note use `--xchr-model` instead of for the X chr

#mkdir -p $plinkoutdir2
plink \
--file $plinkindir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink \
--homozyg \
-chr-set ${i} \
--homozyg-window-het 3 \
--homozyg-window-missing 5 \
--homozyg-kb 500 \
--homozyg-snp 50 \
--out $plinkoutdir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out

## --homozyg \
## --chr-set 38 \
## --homozyg-window-het 3 \
## --homozyg-density 50 \
## --homozyg-window-missing 10 \
## --homozyg-kb 500 \
## --homozyg-snp 50 \
## --homozyg-gap 1000 \
## --homozyg-window-snp 50 \
## --homozyg-window-threshold 0.05 \
## --out $plinkoutdir/MW.raw_variants.${i}.${date}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out

#plink \
#--file $plinkindir/${PREFIX}.raw_variants.${i}.${date}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink \
#--homozyg \
#--homozyg-kb 500 \
#--homozyg-snp 50 \
#--out $plinkoutdir/${PREFIX}.raw_variants.${i}.${date}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out

sleep 5m
