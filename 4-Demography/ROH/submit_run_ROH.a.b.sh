#! /bin/bash

#$ -wd /u/scratch/d/dechavez/BD/ROH/
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subROH
#$ -o /u/scratch/d/dechavez/BD/ROH/log/ROH.out
#$ -e /u/scratch/d/dechavez/BD/ROH/log/ROH.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

/u/scratch/d/dechavez/BD/ROH/

for file in *.txt; do 
${QSUB} -N ROH $SCRIPT_DIR/ROH-a.plink.sh $file
done  

sleep 6h

for file in *.txt; do
ROH-b.catTogetherResults.BD.sh $file 
done
