#! /bin/bash

#$ -cwd
#$ -l h_rt=30:00:00,h_data=2G,highp,h_vmem=60G
#$ -N msmc
#$ -pe shared 11
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv

# run MSMC with default settings (for now)

source /u/local/Modules/default/init/modules.sh
module load python/3.4 ## has to be 3.6! otherwise won't work.
msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master/msmc

rundate=`date +%Y%m%d` # msmc rundate

PREFIX=$1
OUTDIR=/u/scratch/d/dechavez/SA.VCF/Filtered/${date}/msmcAnalysis/output_${rundate}
mkdir -p $OUTDIR


date=20200530 #Input creation date
INPUTDIR=/u/scratch/d/dechavez/SA.VCF/Filtered/${date}/msmcAnalysis/inputFiles

$msmc -t 14 -o $OUTDIR/rails.msmc.${PREFIX}.out $INPUTDIR/chunk_${PREFIX}_*_postMultiHetSep.txt

# use the following if you get an index error message
## -I 0,1
