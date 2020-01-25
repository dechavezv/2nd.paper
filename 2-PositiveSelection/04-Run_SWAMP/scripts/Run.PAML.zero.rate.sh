#!/bin/bash

#$ -l highmem,highp,h_rt=82:00:00,h_data=2G
#$ -pe shared 1
#$ -N SWAMP_PAML_SSJ_BBJ
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/d/dechavez/PAML/PAML/log/SWAMP_BD_PAML.out
#$ -e /u/flashscratch/d/dechavez/PAML/PAML/log/SWAMP_BD_PAML.err
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java/1.7.0_45
module load python
module load perl


export SWAMP=/u/home/d/dechavez/project-rwayne/SWAMP/SWAMP.py
export OUT=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/sequences_before_SWAMP
export Swamp_files=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/sequences_before_SWAMP/scripts

cd ${OUT}
cd $1

echo '############'
echo  Move_Control_files_rate_0
echo '############'

for dir in Tree*;do (cp ${Swamp_files}/codeml_modelA_rate_zero.ctl $dir/modelA/Omega1 && /
cp ${Swamp_files}/codeml_modelA_masked.ctl $dir/modelA/Omega1 && /
cp ${Swamp_files}/codeml_modelAnull_masked.ctl $dir/modelAnull/Omega1 && /
);done

echo '############'
echo PAML_annalysis_rate_0
echo '############'

for dir in Tree*;do (echo $dir && cd $dir/modelA/Omega1 && /
./codeml codeml_modelA_rate_zero.ctl);done
