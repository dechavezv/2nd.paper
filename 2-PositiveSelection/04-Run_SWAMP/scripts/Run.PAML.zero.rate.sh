#!/bin/bash

#$ -l h_rt=15:00:00,h_data=1G
#$ -pe shared 1
#$ -N rate_zero_PAML
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/rate_zero_PAML.out
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/rate_zero_PAML.err
#$ -M dechavezv

echo '############'
echo PAML_annalysis_rate_0
echo '############'

for dir in Dir*;do (echo $dir && cd $dir/tree/modelA/Omega1 && /
./codeml codeml_modelA_rate_zero.ctl);done
