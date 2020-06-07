#! /bin/bash

#$ -cwd
#$ -l h_rt=04:00:00,h_data=8G,highp,h_vmem=30G,highmem_forced=TRUE
#$ -N runROHstep2
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv


source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

wd=/u/scratch/d/dechavez/SA.VCF/Filtered/20200530

cd ${wd}/plinkInputFiles
 
plinkoutdir=$wd/plinkOutputFiles

mkdir -p $plinkoutdir

FILE=${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
OUTDIR=${plinkoutdir}/plinkroh_${1}_${2}_${3}_${4}_${5}_${6}_${7}

mkdir -p ${OUTDIR}

plink --keep-allele-order --autosome-num 38 --bfile ${FILE} \
--homozyg \
-chr-set ${i} \
--homozyg-kb 100 \
--homozyg-snp ${1} \
--homozyg-density ${2} \
--homozyg-gap ${3} \
--homozyg-window-snp ${4} \
--homozyg-window-het ${5} \
--homozyg-window-missing ${6} \
--homozyg-window-threshold ${7} \
--out ${OUTDIR}/${FILE}.out

cd ${OUTDIR}

source /u/local/Modules/default/init/modules.sh
module load R

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH/plot_ROH_20181207.R

R CMD BATCH --no-save --no-restore '--args 'plinkroh_${1}_${2}_${3}_${4}_${5}_${6}_${7}' '${SCRIPT}
