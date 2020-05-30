#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/VCF
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subMaskRails
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/log/reportsfilter.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/log/reportsfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/11_FilterVCF/scripts
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/rails.project/VCF

for file in *.gz; do 
${QSUB} -N FilterVCF $SCRIPT_DIR/Mask_Filter_Rails.sh $file
done  
