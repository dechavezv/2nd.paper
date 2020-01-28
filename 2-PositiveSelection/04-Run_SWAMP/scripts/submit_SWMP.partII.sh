#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP
#$ -l highp,h_rt=26:00:00,h_data=1G
#$ -N II_SWAMP
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/SWAMP_II
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/SWAMP_II
#$ -m abe
#$ -M dechavezv

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/scripts
export DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd ${DIREC}/processing

for dir in dir*; do (echo $dir && cd $dir && $QSUB ${SCRIPTDIR}/SWAMP.sh);done

sleep 15m

cd ${DIREC}
