#! /bin/bash
#$ -cwd
#$ -l h_rt=04:00:00,h_data=8G,highp,h_vmem=30G,highmem_forced=TRUE
#$ -N runROHstep2
#$ -o /u/scratch/d/dechavez/BD/ROH/log/
#$ -e /u/scratch/d/dechavez/BD/ROH/log/
#$ -m abe
#$ -M dechavezv


source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

cd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530/plinkInputFiles

FILE=SA.canids.Plink
OUTDIR=plinkroh_${1}_${2}_${3}_${4}_${5}_${6}_${7}

mkdir -p ${OUTDIR}

${PLINK} --keep-allele-order --autosome-num 38 --bfile ${FILE} \
--homozyg \
--homozyg-kb 100 \
--homozyg-snp ${1} \
--homozyg-density ${2} \
--homozyg-gap ${3} \
--homozyg-window-snp ${4} \
--homozyg-window-het ${5} \
--homozyg-window-missing ${6} \
--homozyg-window-threshold ${7} \
--out ${OUTDIR}/${FILE}

cd ${OUTDIR}

source /u/local/Modules/default/init/modules.sh
module load R

SCRIPT=/u/home/j/jarobins/project-rwayne/utils/scripts/plink_roh/plot_ROH_20181207.R

R CMD BATCH --no-save --no-restore '--args 'plinkroh_${1}_${2}_${3}_${4}_${5}_${6}_${7}' '${SCRIPT}

