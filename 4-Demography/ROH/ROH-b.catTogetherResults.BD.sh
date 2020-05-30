#! /bin/bash

#$ -cwd
#$ -l h_rt=01:00:00,h_data=1G,highp,h_vmem=6G
#$ -N Concat.plinkROH
#$ -o /u/scratch/d/dechavez/BD/ROH/log/Concat.plink.out
#$ -e /u/scratch/d/dechavez/BD/ROH/log/Concat.plink.err
#$ -m abe
#$ -M dechavezv

echo '************* Concatenating results of ROH **************************************************'

## step b:
# cat together all the ROHs:
date=2019.09.25 # date of vcf calling
Samples=$1
PREFIX=${Samples%.txt}
wd=u/scratch/d/dechavez/BD/ROH
plinkoutdir=$wd/plinkOutputFiles

mkdir -p ${plinkoutdir}/cattedResults


# set up header
		       
head -n1 $plinkoutdir/${PREFIX}.01.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out.hom >${plinkoutdir}/cattedResults/${PREFIX}.chr1_38.catted.hom

for i in {01..38}; do (plinkHom=$plinkoutdir/${PREFIX}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out.hom && \
grep -v "FID" $plinkHom >> ${plinkoutdir}/cattedResults/${PREFIX}.chr1_38.catted.hom);done

# may also want to delete .summary files as they are huge! 
rm $plinkoutdir/*summary 

echo '************* Done Concatenating results of ROH **************************************************'
