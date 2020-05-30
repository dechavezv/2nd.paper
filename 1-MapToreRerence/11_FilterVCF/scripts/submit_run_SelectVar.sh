#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF/ROH
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subbamfltr
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF/ROH/log/reportsfilter.out
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF/ROH/log/reportsfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/11_FilterVCF/scripts
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/BD/VCF/ROH

for file in *.txt; do 
${QSUB} -N SlectVar $SCRIPT_DIR/run_SelectVariants_And_OnlyPassSites.sh $file
done  
