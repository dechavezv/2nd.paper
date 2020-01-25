#!/bin/bash

#$ -l highmem,highp,h_rt=82:00:00,h_data=2G
#$ -pe shared 1
#$ -N Run_SWAMP
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
export Branch=/u/home/d/dechavez/project-rwayne/SWAMP/Branch_canids_July18th_2019_SSJ_BBJ.txt
export OUT=/u/flashscratch/d/dechavez/PAML/PAML/PAML_out/Missing_SWAMP 
export Swamp_files=/u/home/d/dechavez/project-rwayne/scripts/SWAMP
data=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML


mkdir SWAMP_sequneces_10in5
mkdir SWAMP_sequneces_10in5_AND_3in5


## echo '#######################'
## echo Editing_phylip_files
## echo '######################'
## for dir in Tree*;do (cd $dir/modelA/Omega1 && for file in align.phy;do (perl -pe 's/([a-zA-Z]+)\s+/\1\n/g' $file > align_2.phy && rm align.phy && mv align_2.phy align.phy);done);done 

echo '#######################'
echo Runing_SWAMP.10in15....
echo '######################'

for dir in Tree*; do (echo $dir && \
python ${SWAMP} -i $dir/modelA/Omega1 \
-b ${Branch} -t 10 -w 15 --interscan);done

echo '#######################'
echo Get_redy_for_next_round
echo '######################'
for dir in Tree*; do (echo $dir && \
cd $dir/modelA/Omega1 && mv align_masked.phy align.phy && \
cp align.phy ../../modelAnull/Omega1);done

echo '#######################'
echo Runing_SWAMP...3in5...
echo '######################'
for dir in Tree*; do (echo $dir && \
python ${SWAMP} -i $dir/modelA/Omega1 \
-b ${Branch} -t 3 -w 5 --interscan);done

echo '############'
echo Move_Files_modelAnull
echo '############'
for dir in Tree*; do (cd $dir/modelA/Omega1 && cp align_masked.phy ../../modelAnull/Omega1);done

for dir in Tree*;do (cd $dir/modelA/Omega1 && ./codeml codeml_modelA_masked.ctl && /
cd .. && cd .. && /
cd modelAnull/Omega1 && ./codeml codeml_modelAnull_masked.ctl);done
 
for dir in Tree*; do (echo $dir && cd $dir/modelA/Omega1 && pwd && /
cp align_masked.phy $dir.phy && /
mv $dir.phy ${data}/SWAMP_sequneces_10in5_AND_3in5);done
