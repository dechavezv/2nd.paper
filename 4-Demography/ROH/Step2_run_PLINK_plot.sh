#! /bin/bash

#$ -cwd
#$ -l h_rt=04:00:00,h_data=8G,highp,h_vmem=30G
#$ -N runROHstep2
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38

#highmem_forced=TRUE

source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

wd=/u/scratch/d/dechavez/SA.VCF/Filtered/20200530
cd ${wd}/plinkInputFiles

plinkoutdir=$wd/plinkOutputFiles
mkdir -p $plinkoutdir

# need to get chr name from file
i=$(printf "%02d" "$SGE_TASK_ID")
Sample=$1

FILE=${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
OUTDIR=${plinkoutdir}/plinkroh_${2}_${3}_${4}_${5}_${6}_${7}_${8}

### mkdir -p ${OUTDIR}

### plink --keep-allele-order --file ${FILE} \
### --homozyg \
### -chr-set ${i} \
### --homozyg-kb 100 \
### --homozyg-snp ${2} \
### --homozyg-density ${3} \
### --homozyg-gap ${4} \
### --homozyg-window-snp ${5} \
### --homozyg-window-het ${6} \
### --homozyg-window-missing ${7} \
### --homozyg-window-threshold ${8} \
### --out ${OUTDIR}/${FILE}.out

cd ${OUTDIR}
### rm *summary

### mkdir -p catted

#testing_povide name of sample
head -n1 Sve338.01.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out.hom  > catted/SAcanids.catted.hom

for file in *.hom do (plinkdHom=$file && \
grep -v "FID" $plinkHom >> catted/SAcanids.catted.hom);done

cd  catted/

source /u/local/Modules/default/init/modules.sh
module load R

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH/plot_ROHStep2.R

R CMD BATCH --no-save --no-restore '--args 'plinkroh_${2}_${3}_${4}_${5}_${6}_${7}_${8}/catted' '${SCRIPT}
