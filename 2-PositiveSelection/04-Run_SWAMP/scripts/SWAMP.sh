#!/bin/bash

#$ -l h_rt=15:00:00,h_data=1G
#$ -pe shared 1
#$ -N Run_SWAMP
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/SWAMP_filter.out
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/SWAMP_filter.err
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java/1.7.0_45
module load python
module load perl

export SWAMP=/u/home/d/dechavez/project-rwayne/SWAMP/SWAMP.py
export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP
export Branch=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/scripts/branch_canids.txt
export data=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/SWAMP_sequneces_10in5_AND_3in5

mkdir SWAMP_sequneces_10in5
mkdir SWAMP_sequneces_10in5_AND_3in5

echo '#######################'
echo Need a two-line philip file
echo '######################'
for dir in Dir_*;do (cd $dir/tree/modelA/Omega1 && \
for file in align.phy;do (perl -pe 's/([a-zA-Z]+)\s+/\1\n/g' \
$file > align_2.phy && rm align.phy && mv align_2.phy align.phy);done);done 

echo '#######################'
echo Runing_SWAMP...10in15....
echo '######################'
for dir in Dir_*; do (echo $dir && cd $dir/tree/modelA && \
python ${SWAMP} -i Omega1 \
-b ${Branch} -t 10 -w 15 --interscan);done

echo '#######################'
echo Get_redy_for_next_round
echo '######################'
for dir in Dir_*; do (echo $dir && cd $dir/tree/modelA/Omega1 && \
mv align_masked.phy align.phy && \
cp align.phy ../../modelAnull/Omega1);done

echo '#######################'
echo Runing_SWAMP...3in5...
echo '######################'
for dir in Dir_*; do (echo $dir && cd $dir/tree/modelA && \
python ${SWAMP} -i Omega1 \
-b ${Branch} -t 3 -w 5 --interscan);done

echo '############'
echo Move_Files_modelAnull
echo '############'
for dir in Dir_*; do (cd $dir/tree/modelA/Omega1 && cp align_masked.phy ../../modelAnull/Omega1);done

echo '############'
echo  Run PAML on masked files
echo '############'
for dir in Dir_*;do (cd $dir/tree/modelA/Omega1 && ./codeml codeml_modelA_masked.ctl && /
cd ../../modelAnull/Omega1 && ./codeml codeml_modelAnull_masked.ctl);done

echo '############'
echo  Move masked sequences to Ouput location
echo '############'
for dir in Dir_*; do (echo $dir && cd $dir/tree/modelA/Omega1 && /
cp align_masked.phy $dir.phy && /
mv $dir.phy ${data});done
